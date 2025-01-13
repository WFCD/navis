import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/hive_registrar.g.dart';
import 'package:warframestat_repository/src/arsenal_database.dart';
import 'package:warframestat_repository/src/cache_client.dart';
import 'package:warframestat_repository/src/models/regions.dart';
import 'package:warframestat_repository/src/utils/utils.dart';

///
const userAgent = 'navis';
const _name = 'WarframestatRepository';

typedef CraigRegion = ({List<CraigNode> nodes, List<CraigJunction> junctions});

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({
    required ArsenalDatabase database,
    required Client client,
  })  : _database = database,
        _client = client {
    Hive.registerAdapters();
  }

  final ArsenalDatabase _database;
  final Client _client;

  /// The locale request will be made for
  Language language = Language.en;

  final _cacheClients = <Duration, CacheClient>{};
  Future<CacheClient> _cacheClient(Duration cacheTime) async {
    Hive.init(Directory.systemTemp.absolute.path);

    // Hive will return the same box if it's already opened
    final cache =
        await Hive.openBox<HiveCacheItem>('warframestat_repository_cache');

    if (_cacheClients.containsKey(cacheTime)) return _cacheClients[cacheTime]!;

    _cacheClients[cacheTime] = CacheClient(
      cacheTime: cacheTime,
      client: _client,
      cacheBox: cache,
    );

    return _cacheClients[cacheTime]!;
  }

  /// Get the current worldstate
  Future<Worldstate> fetchWorldstate() async {
    const cacheTime = Duration(seconds: 60);
    final client = WorldstateClient(
      client: await _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchWorldstate();
  }

  /// Get static list of synthesis targets
  ///
  /// I doubt the list will be updated since DE doesn't really add much on their
  /// end so caching for even a year is perfectly fine
  Future<List<SynthTarget>> fetchTargets() async {
    const cacheTime = Duration(days: 30);
    final client = SynthTaretClient(
      client: await _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchTargets();
  }

  /// Search warframe-items
  Future<List<MinimalItem>> searchItems(String query) async {
    const cacheTime = Duration(days: 7);
    final client = WarframeItemsClient(
      client: await _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.search(query);
  }

  /// Get one item based on unique name
  Future<Item?> fetchItem(String uniqueName) async {
    const cacheTime = Duration(minutes: 5);
    final client = WarframeItemsClient(
      client: await _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  Future<Profile> fetchProfile(String username) async {
    const cacheTime = Duration(minutes: 60);
    final client = ProfileClient(
      username: username,
      client: await _cacheClient(cacheTime),
      // ua: userAgent,
      language: language,
    );

    return client.fetchProfile();
  }

  Future<void> updateArsenalItems({bool update = false}) async {
    const stallTime = Duration(days: 7);

    final lastUpdate = await _database.lastUpdate();
    final lastUpdateElapsed =
        lastUpdate?.difference(DateTime.timestamp()) ?? stallTime;

    final needsUpdate = lastUpdateElapsed >= stallTime || update;
    if (!needsUpdate) return;

    final client = WarframeItemsClient(
      client: _client,
      ua: userAgent,
      language: language,
    );

    developer.log('updating arsenal manifest', name: _name);
    final items =
        List<MinimalItem>.from(await client.fetchAllItems(minimal: true))
          ..removeWhere((i) => i.masterable != true);

    await _database.updateItems(items);
    await _database.updateTimeStamp();
  }

  Future<List<MasteryProgress>> syncXpInfo(String username) async {
    developer.log('syncing xp info', name: _name);

    // Share the same catch as profile, XP info doesn't change often and this
    // keeps the profile hydrated
    final xpInfo = (await fetchProfile(username)).loadout.xpInfo;
    await _database.updateXp(xpInfo);

    return _database.fetchArsenal();
  }

  Future<CraigRegion> fetchRegions() async {
    final client = await _cacheClient(const Duration(days: 30));
    final res =
        await client.get(Uri.parse('https://cdn.truemaster.app/regions.json'));

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final nodes = _jsonMapList(json['nodes'] as List<dynamic>);
    final junctions = _jsonMapList(json['junctions'] as List<dynamic>);

    return (
      nodes: nodes.map(CraigNode.fromJson).toList(),
      junctions: junctions.map(CraigJunction.fromJson).toList()
    );
  }

  List<Map<String, dynamic>> _jsonMapList(List<dynamic> list) {
    return List<Map<String, dynamic>>.from(list);
  }
}
