import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/src/cache_client.dart';

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
    const cacheTime = Duration(hours: 12);
    final client = WarframeItemsClient(
      client: CacheClient(
        key: 'deal_${language.name}',
        cacheTime: cacheTime,
        cache: cache,
        client: _client,
      ),
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
    final client = WarframeItemsClient(
      client: _client,
      ua: userAgent,
      language: language,
    );

    return client.search(query);
  }

  /// Get one item based on unique name
  Future<Item> fetchItem(String uniqueName) {
    final client = WarframeItemsClient(
      client: _client,
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  /// Fetch Player profile
  Future<Profile> fetchProfile(String username) {
    const cacheTime = Duration(minutes: 60);
    final client = ProfileClient(
      username: username,
      language: language,
      client: _cacheClient('xpInfo_${language.name}', cacheTime),
    );

    return client.fetchProfile();
  }
}
