// ignore_for_file: experimental_member_use Its gonna get unmarked I swear

import 'dart:isolate';

import 'package:arbi_api/arbi_api.dart';
import 'package:http/http.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_repository/src/constants.dart';
import 'package:warframe_repository/src/models/slim_item.dart';
import 'package:warframe_repository/src/utils/utils.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart'
    show Arbitration, Item, ItemCommon, WarframeItemsClient, toItem;
import 'package:worldstate_models/worldstate_models.dart';

/// {@template warframe_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeRepository {
  /// {@macro warframe_repository}
  WarframeRepository({required Client client, required CacheManager cache, required CodexDatabase codex})
    : _client = client,
      _cacheManager = cache,
      _codex = codex;

  final Client _client;
  final CacheManager _cacheManager;
  final CodexDatabase _codex;

  WorldstateLocale locale = .en;

  WarframeApi get _warframeApi => WarframeApi(client: _client);
  WarframeItemsClient get _items => WarframeItemsClient(client: _client, language: localeToLang(locale));

  List<SynthTarget> targets() => synthTargets(locale);
  bool verifyUserData(String json) => _warframeApi.verifyUserData(json);
  UserData user(String data) => UserData.raw(data);

  Stream<Worldstate> worldstateEmitter() async* {
    yield* Stream.periodic(CacheTime.worldstateRefreshTime, (_) => buildWorldstate()).asyncMap((f) => f);
  }

  Future<Worldstate> buildWorldstate() async {
    final key = '${CacheKeys.worldstate}_${locale.name}';
    final cached = await _cacheManager.get<Map<String, dynamic>>(key);
    if (cached != null) return Isolate.run(() => Worldstate.fromMap(cached));

    final drops = await buildDropData();
    final worldstate = await _warframeApi.fetchWorldstate(drops, locale);
    await _cacheManager.set(key, worldstate.toMap(), ttl: CacheTime.worldstateRefreshTime);

    return worldstate;
  }

  Future<DropData> buildDropData() async {
    final cached = await _cacheManager.get<Map<String, dynamic>>(CacheKeys.dropData);
    if (cached != null) return Isolate.run(() => DropData.fromMap(cached));

    final data = await _warframeApi.fetchDropData();
    await _cacheManager.set(CacheKeys.dropData, data.toMap(), ttl: CacheTime.dropDataRefresh);

    return data;
  }

  Future<Profile> fetchProfile(String id) async {
    final cache = await _cacheManager.get<Map<String, dynamic>>(CacheKeys.profile);
    if (cache != null) return Isolate.run(() => Profile.fromMap(cache));

    final data = await _warframeApi.fetchProfile(id);
    await _cacheManager.set(CacheKeys.profile, data.toMap(), ttl: CacheTime.profileRefreshTime);

    return data;
  }

  Future<Item?> fetchItem(String uniqueName) async {
    final cached = await _cacheManager.get<Map<String, dynamic>>(uniqueName);
    if (cached != null) return Isolate.run(() => toItem(cached));

    final item = await _items.fetchItem(uniqueName);
    if (item == null) return null;

    await _cacheManager.set(uniqueName, item.toJson(), ttl: CacheTime.itemRefreshTime);
    return item;
  }

  Future<List<SearchResult>> search(String name) async {
    final dbItems = await _codex.search(name);
    if (dbItems.isNotEmpty) return dbItems.map(SearchResult.fromCodexItem).toList();

    final items = await _items.search<ItemCommon>(name);
    return items.map(SearchResult.fromItem).toList();
  }

  Future<Arbitration> fetchArbitration() async {
    final cached = await _cacheManager.get<List<dynamic>>(CacheKeys.arbitrations);
    if (cached != null) {
      return Isolate.run(() {
        final arbis = List<Map<String, dynamic>>.from(cached).map(Arbitration.fromJson).toList();
        return arbis.current;
      });
    }

    final arbis = await ArbiApi(_client).fetchArbis();
    final ttl = DateTime.timestamp().difference(arbis.last.expiry);
    await _cacheManager.set(CacheKeys.arbitrations, arbis.map((i) => i.toJson()).toList(), ttl: ttl);

    return arbis.current;
  }

  Future<void> initializeCodex() async {
    final singleItem = await (_codex.select(_codex.codexItems)..limit(1)).getSingleOrNull();
    if (singleItem != null) return;

    try {
      final items = await _items.fetchAllItems(props: slimItemProps, encoder: _encode) as List<SlimItem>;
      final inserts = items.map((i) => i.toCodexItem()).toList();

      await _codex.addItems(inserts);
    } on Exception {
      return;
    }
  }

  static SlimItem _encode(Map<String, dynamic> item) {
    final name = item['name'] as String;
    final uniqueName = item['uniqueName'] as String;
    final category = item['category'] as String;

    if (name == 'Venari' || name == 'Venari Prime') item['type'] = 'Pets';
    if (category == 'Arcanes') item['type'] = 'Arcane';

    if (uniqueName.contains(RegExp('MoaPetParts|ZanukaPetParts'))) {
      item['type'] = 'Pet Resource';
    }

    return SlimItem.fromJson(item);
  }
}
