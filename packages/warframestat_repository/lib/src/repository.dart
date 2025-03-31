import 'dart:convert';

import 'package:cache_client/cache_client.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/src/models/regions.dart';

///
const userAgent = 'navis';

typedef CraigRegion = ({List<CraigNode> nodes, List<CraigJunction> junctions});

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({
    required Box<CachedItem> cache,
    required Client client,
  })  : _cache = cache,
        _client = client;

  final Box<CachedItem> _cache;
  final Client _client;

  /// The locale request will be made for
  Language language = Language.en;

  /// Get the current worldstate
  Future<Worldstate> fetchWorldstate() async {
    final client = WorldstateClient(
      client: CacheClient(cache: _cache, client: _client),
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
    final client = SynthTargetClient(
      client: CacheClient(cache: _cache, ttl: const Duration(days: 30), client: _client),
      ua: userAgent,
      language: language,
    );

    return client.fetchTargets();
  }

  /// Search warframe-items
  Future<List<MinimalItem>> searchItems(String query) async {
    final client = WarframeItemsClient(
      client: CacheClient(cache: _cache, ttl: const Duration(days: 1), client: _client),
      ua: userAgent,
      language: language,
    );

    return client.search(query);
  }

  /// Get one item based on unique name
  Future<Item?> fetchItem(String uniqueName) async {
    final client = WarframeItemsClient(
      client: CacheClient(cache: _cache, ttl: const Duration(minutes: 30), client: _client),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  Future<CraigRegion> fetchRegions() async {
    final client = CacheClient(cache: _cache, ttl: const Duration(days: 30), client: _client);
    final res = await client.get(Uri.parse('https://cdn.truemaster.app/regions.json'));

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final nodes = _jsonMapList(json['nodes'] as List<dynamic>);
    final junctions = _jsonMapList(json['junctions'] as List<dynamic>);

    return (nodes: nodes.map(CraigNode.fromJson).toList(), junctions: junctions.map(CraigJunction.fromJson).toList());
  }

  List<Map<String, dynamic>> _jsonMapList(List<dynamic> list) {
    return List<Map<String, dynamic>>.from(list);
  }
}
