import 'package:collection/collection.dart';
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
  WarframestatRepository({Client? client}) : _client = client ?? Client();

  final Client _client;

  /// The locale request will be made for
  Language language = Language.en;

  final _cacheClients = <Duration, CacheClient>{};
  CacheClient _cacheClient(Duration cacheTime) {
    if (_cacheClients.containsKey(cacheTime)) return _cacheClients[cacheTime]!;

    _cacheClients[cacheTime] = CacheClient(
      cacheTime: cacheTime,
      client: _client,
    );

    return _cacheClients[cacheTime]!;
  }

  /// Get the current worldstate
  Future<Worldstate> fetchWorldstate() {
    const cacheTime = Duration(seconds: 60);
    final client = WorldstateClient(
      client: _cacheClient(cacheTime),
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
      client: _cacheClient(cacheTime),
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
      client: _cacheClient(cacheTime),
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
      client: _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.search(query);
  }

  /// Get one item based on unique name
  Future<Item> fetchItem(String uniqueName) {
    const cacheTime = Duration(minutes: 5);
    final client = WarframeItemsClient(
      client: _cacheClient(cacheTime),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }
}
