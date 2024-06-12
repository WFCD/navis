import 'dart:convert';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/src/cache_client.dart';
import 'package:warframestat_repository/src/models/node_mastery.dart';

///
const userAgent = 'navis';

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({required this.cache, Client? client})
      : _client = client ?? Client();

  /// The [Box] used for caching
  final Box<Map<dynamic, dynamic>> cache;
  final Client _client;

  /// The locale request will be made for
  Language language = Language.en;

  CacheClient _cacheClient(String key, Duration cacheTime) {
    return CacheClient(
      key: key,
      cacheTime: cacheTime,
      cache: cache,
      client: _client,
    );
  }

  /// Get the current worldstate
  Future<Worldstate> fetchWorldstate() {
    const cacheTime = Duration(seconds: 60);
    final client = WorldstateClient(
      client: _cacheClient('worldstate_${language.name}', cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchWorldstate();
  }

  /// Get static list of synthesis targets
  ///
  /// I doubt the list will be updated since DE doesn't really add much on their
  /// end so caching for even a year is perfectly fine
  Future<List<SynthTarget>> fetchTargets() {
    const cacheTime = Duration(days: 30);
    final client = SynthTaretClient(
      client: _cacheClient('targets_${language.name}', cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchTargets();
  }

  /// Fetch the [MinimalItem] info for whatever item Darvo is currently selling.
  /// Will catch the item until the end of the day (UTC)
  Future<MinimalItem?> fetchDealInfo(String uniqueName, String name) async {
    const cacheTime = Duration(minutes: 30);
    final client = WarframeItemsClient(
      client: _cacheClient('deal_${language.name}_$uniqueName', cacheTime),
      ua: userAgent,
      language: language,
    );

    final results = await client.search(name);

    var item = results.firstWhereOrNull((i) => i.uniqueName == uniqueName);
    if (item == null) {
      final internalName = uniqueName.split('/').last;
      item = results.firstWhereOrNull(
        (i) => i.uniqueName.contains(internalName),
      );
    }

    return item;
  }

  /// Search warframe-items
  Future<List<MinimalItem>> searchItems(String query) {
    const cacheTime = Duration(minutes: 5);
    final client = WarframeItemsClient(
      client: _cacheClient('search_${language.name}_$query', cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.search(query);
  }

  /// Get one item based on unique name
  Future<Item> fetchItem(String uniqueName) {
    const cacheTime = Duration(minutes: 5);
    final client = WarframeItemsClient(
      client: _cacheClient('item_${language.name}_$uniqueName', cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  /// Fetch player profile
  Future<Profile> fetchProfile(String username) {
    const cacheTime = Duration(minutes: 60);
    final client = ProfileClient(
      client: _cacheClient('profile_${language.name}_$username', cacheTime),
      language: language,
      username: username,
    );

    return client.fetchProfile();
  }

  Future<List<NodeMastery>> fetchNodeMastery() async {
    final client = CacheClient(
      key: 'node_mastery',
      cacheTime: const Duration(days: 30),
      cache: cache,
    );

    final uri = Uri.parse('https://cdn.truemaster.app/regions.json');
    final response = await client.get(uri);

    return Isolate.run(() => _parseNodeMastery(response.body));
  }

  static List<NodeMastery> _parseNodeMastery(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;

    return List<Map<String, dynamic>>.from(json['nodes'] as List<dynamic>)
        .map(NodeMastery.fromJson)
        .toList();
  }
}
