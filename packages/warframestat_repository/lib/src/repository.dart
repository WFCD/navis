import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/hive_registrar.g.dart';
import 'package:warframestat_repository/src/cache_client.dart';

///
const userAgent = 'navis';

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({Client? client}) : _client = client ?? Client() {
    Hive.registerAdapters();
  }

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
}
