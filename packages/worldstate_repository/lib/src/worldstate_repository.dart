import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/src/exceptions.dart';
import 'package:worldstate_repository/src/worldstate_cache.dart';

const _refreshTime = Duration(seconds: 1);
const String _userAgent = 'navis';

/// {@template worldstate_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WorldstateRepository {
  /// {@macro worldstate_repository}
  WorldstateRepository({Client? client, required WarframestatCache cache})
      : _client = client ?? Client(),
        _cache = cache;

  final Client _client;
  final WarframestatCache _cache;

  /// Retrives a list of [SynthTarget]s.
  ///
  /// Keep in mind that this doesn't get Player specific targets only location
  /// of known targets.
  Future<List<SynthTarget>> getSynthTargets({
    Language language = Language.en,
  }) async {
    final client = SynthTaretClient(
      client: _client,
      language: language,
      ua: _userAgent,
    );

    final cached = _cache.getCachedTargets();

    if (cached != null) {
      return cached;
    }

    final targets = await client.fetchTargets();
    _cache.cacheSynthTargets(targets);

    return targets;
  }

  /// Gets the current worldstate via WFCD's worldstate-status API.
  Future<Worldstate> getWorldstate({
    Language language = Language.en,
    bool forceUpdate = false,
  }) async {
    final now = DateTime.now();
    final timestamp = _cache.getCachedStateTimestamp();
    final age = timestamp?.difference(now).abs() ?? _refreshTime;

    if (age >= _refreshTime || forceUpdate) {
      try {
        final client = WorldstateClient(
          client: _client,
          language: language,
          ua: _userAgent,
        );

        final state = await client.fetchWorldstate();

        _cache.cacheWorldstate(state);

        return state;
      } on ServerException {
        final cache = _cache.getCachedState();

        if (cache != null) return cache;

        rethrow;
      } on FormatException {
        final cache = _cache.getCachedState();

        if (cache != null) return cache;

        rethrow;
      }
    } else {
      final cache = _cache.getCachedState();

      if (cache != null) return cache;

      // If there's nothing in the cache we want to force an update, and if
      // there's an error getting a new worldstate a ServerExcpetion will be
      // thrown
      return getWorldstate(forceUpdate: true);
    }
  }

  /// Retrives item information about a deal item using WFCD's Warframe-items.
  ///
  /// Note: Not all deals will have item information, if no information is found
  /// this function will throw an [ItemNotFoundException].
  ///
  /// Warframe-items: https://github.com/WFCD/warframe-items
  Future<Item?> getDealInfo(
    String uniqueName,
    String name, {
    Language language = Language.en,
  }) async {
    final client = WarframeItemsClient(
      client: _client,
      language: language,
      ua: _userAgent,
    );

    final cachedId = _cache.getCachedDealId();

    if (cachedId != null && cachedId != uniqueName || cachedId == null) {
      // If for whatever reason getItemDealInfo throws an error then we're just
      // gonna let it bubble up since at this point the Item is different and
      // there is no point in returning the cached version.
      final results = await client.search(name);
      final internalName = uniqueName.split('/').last;
      final deal =
          results.firstWhereOrNull((i) => i.uniqueName.contains(internalName));

      if (deal != null) _cache.cacheDealInfo(uniqueName, deal);

      return deal;
    } else {
      // Since the ID is saved with the deal information, we can safetly assume
      // that the deal information itself is not empty. And since
      // getItemDealInfo throws when an item isn't found it will never save an
      // empty deal.
      //
      // Note: Darvo's Deal widget itself has a way of working around this error
      // by showing a bare bone widget with just the deal information itself.
      return _cache.getCachedDeal(uniqueName)!;
    }
  }

  /// Returns search results from Warframe-Items.
  ///
  /// There is no caching for item searches.
  ///
  /// Note: some item images may be missing, due to how DE structures there
  /// information parsing can also throw some mismatch most usually when new
  /// items are added.
  ///
  /// Warframe-items: https://github.com/WFCD/warframe-items
  Future<List<Item>> searchItems(
    String query, {
    Language language = Language.en,
  }) async {
    final client = WarframeItemsClient(
      client: _client,
      language: language,
      ua: _userAgent,
    );

    return client.search(query);
  }
}
