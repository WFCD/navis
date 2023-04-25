import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:user_settings/user_settings.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/src/exceptions.dart';
import 'package:worldstate_repository/src/worldstate_cache.dart';

const _kRefreshTime = Duration(seconds: 1);

/// {@template worldstate_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WorldstateRepository {
  /// {@macro worldstate_repository}
  const WorldstateRepository({
    required UserSettings settings,
    required WarframestatCache cache,
    WorldstateComputeRunners? runners,
  })  : _settings = settings,
        _cache = cache,
        _runners = runners ?? const WorldstateComputeRunners();

  final WarframestatCache _cache;
  final UserSettings _settings;

  // Only use for testing and nothing else. Unless for some reason we need this
  // to be platform specfic it shouldn't be touched outside of testing
  final WorldstateComputeRunners _runners;

  Language get _language =>
      Language.values.byName(_settings.language.languageCode);

  /// Retrives a list of [SynthTarget]s.
  ///
  /// Keep in mind that this doesn't get Player specific targets only location
  /// of known targets.
  Future<List<SynthTarget>> getSynthTargets() async {
    final cached = _cache.getCachedTargets();

    if (cached != null) {
      return cached;
    }

    final targets = await _runners.getTargets(_language);
    _cache.cacheSynthTargets(targets);

    return targets;
  }

  /// Gets the current worldstate via WFCD's worldstate-status API.
  Future<Worldstate> getWorldstate({bool forceUpdate = false}) async {
    final now = DateTime.now();
    final timestamp = _cache.getCachedStateTimestamp();
    final age = timestamp?.difference(now).abs() ?? _kRefreshTime;

    if (age >= _kRefreshTime || forceUpdate) {
      try {
        final state = await _runners.getWorldstate(_language);

        if (state == null) throw ServerException('worldstate empty');
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
  Future<Item?> getDealInfo(String id, String name) async {
    final cachedId = _cache.getCachedDealId();

    if (cachedId != null && cachedId != id || cachedId == null) {
      // If for whatever reason getItemDealInfo throws an error then we're just
      // gonna let it bubble up since at this point the Item is different and
      // there is no point in returning the cached version.
      final deal = await _runners.getItemDealInfo(name, _language);
      if (deal != null) _cache.cacheDealInfo(id, deal);

      return deal;
    } else {
      // Since the ID is saved with the deal information, we can safetly assume
      // that the deal information itself is not empty. And since
      // getItemDealInfo throws when an item isn't found it will never save an
      // empty deal.
      //
      // Note: Darvo's Deal widget itself has a way of working around this error
      // by showing a bare bone widget with just the deal information itself.
      return _cache.getCachedDeal(id)!;
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
  Future<List<Item>> searchItems(String text) async {
    final request = _ItemSearch(query: text, language: _language);

    return _runners.searchItems(request);
  }
}

// coverage: ignore-start
/// {@template runners}
/// Holds functions used to fetch worldstate information in a seperate isolate.
///
/// Should not be used directly and is only visible for testing purposes.
/// [WorldstateRepository] uses this with caching.
/// {@endtemplate}
@visibleForTesting
class WorldstateComputeRunners {
  /// {@macro runners}
  const WorldstateComputeRunners();

  static const String userAgent = 'navis';

  /// Returns an instance of [Worldstate]
  Future<Worldstate?> getWorldstate(Language language) async {
    return await compute(_getWorldstate, language);
  }

  static Future<Worldstate?> _getWorldstate(Language language) {
    final client = WorldstateClient(language: language, ua: userAgent);

    return client.currentState();
  }

  /// Returns a list of [SynthTarget]
  Future<List<SynthTarget>> getTargets(Language language) async {
    try {
      return await compute(_getTargets, language);
    } catch (e) {
      throw const ServerException('Error retriving targets.');
    }
  }

  static Future<List<SynthTarget>> _getTargets(Language language) {
    return SynthTaretClient(language: language, ua: userAgent).getTargets();
  }

  /// Returns one instance of [Item], will throw [ItemNotFoundException] if
  /// it's unable to find a matching [Item] from [name].
  Future<Item?> getItemDealInfo(String uniqueName, Language language) async {
    try {
      final deal = await compute(
          _getDealInfo, _ItemSearch(query: uniqueName, language: language));

      return deal;
    } catch (e) {
      throw const ServerException(
        "Error retriving information on deal's item.",
      );
    }
  }

  static Future<Item?> _getDealInfo(_ItemSearch info) async {
    final client = WarframeItemsClient(language: info.language, ua: userAgent);
    final results = List<Item?>.from(await client.search(info.query));

    return results.firstWhereOrNull((r) =>
        r?.name.toLowerCase().contains(info.query.toLowerCase()) ?? false);
  }

  /// Searchs for Items using the worldstate-status warframe-items endpoint in
  /// a seperate isolate
  Future<List<Item>> searchItems(_ItemSearch search) {
    try {
      return compute(_searchhItems, search);
    } on Exception {
      throw const ServerException('Error communication with APi.');
    }
  }

  static Future<List<Item>> _searchhItems(_ItemSearch search) {
    final client =
        WarframeItemsClient(language: search.language, ua: userAgent);

    return client.search(search.query);
  }
}

class _ItemSearch {
  const _ItemSearch({required this.query, required this.language});

  final String query;
  final Language language;
}
// coverage: ignore-end
