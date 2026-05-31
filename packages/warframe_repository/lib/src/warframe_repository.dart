// ignore_for_file: experimental_member_use Its gonna get unmarked I swear

import 'dart:isolate';

import 'package:arbi_api/arbi_api.dart';
import 'package:http/http.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:navis_codex/navis_codex.dart' hide XpItem;
import 'package:profile_models/profile_models.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_repository/src/constants.dart';
import 'package:warframe_repository/src/utils/utils.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart'
    show Arbitration, Item, ItemProps, WarframeItemsClient, toItem;
import 'package:worldstate_models/worldstate_models.dart';

typedef MasterableItem = ({CodexItem item, int xp});

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
    if (cache != null) {
      final profile = await Isolate.run(() => Profile.fromMap(cache));
      if (profile.id == id) return profile;
    }

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

    final items = await _items.searchRaw(name, props: [.uniqueName, .name, .description, .imageName]);
    return items.map(SearchResult.fromMap).toList();
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

  Future<bool> updateCodex({String? buildLabel, bool forceUpdate = false}) async {
    if (buildLabel == await _codex.lastBuild) return false;
    if (!forceUpdate && buildLabel == null) return false;

    const codexProps = <ItemProps>[
      .uniqueName,
      .name,
      .description,
      .imageName,
      .type,
      .category,
      .vaulted,
      .masterable,
      .maxLevelCap,
      .wikiaUrl,
      .wikiaThumbnail,
    ];

    try {
      final items = await _items.fetchAllItemsRaw(codexProps);
      final inserts = items.map(encodeCodexItem).toList();

      await _codex.addItems(inserts);
      if (buildLabel != null) await _codex.updateBuild(buildLabel);

      return true;
    } on Exception {
      return false;
    }
  }

  Future<List<MasterableItem>> buildXpInfo(List<XpItem> xpInfo) async {
    final masterableItems = await _codex.fetchMasterable();
    final mappedXpItems = {for (final x in xpInfo) x.uniqueName: x.xp};

    return masterableItems.map((i) => (item: i, xp: mappedXpItems[i.uniqueName] ?? 0)).toList();
  }
}
