import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/src/exceptions.dart';
import 'package:worldstate_repository/src/request_types.dart';
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

  /// Retrives a list of [SynthTarget]s.
  ///
  /// Keep in mind that this doesn't get Player specific targets only location
  /// of known targets.
  Future<List<SynthTarget>> getSynthTargets() async {
    final cached = _cache.getCachedTargets();

    if (cached != null) {
      return cached;
    }

    final targets = await _runners.getTargets();
    _cache.cacheSynthTargets(targets);

    return targets;
  }

  /// Gets the current worldstate via WFCD's worldstate-status API.
  Future<Worldstate> getWorldstate({bool forceUpdate = false}) async {
    final now = DateTime.now();
    final timestamp = _cache.getCachedStateTimestamp();
    final age = timestamp?.difference(now).abs() ?? _kRefreshTime;
    final request = WorldstateRequestType(
      locale: _settings.language?.languageCode ?? 'en',
      platform: _settings.platform,
    );

    if (age >= _kRefreshTime || forceUpdate) {
      try {
        final state = await _runners.getWorldstate(request);
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
  Future<Item> getDealInfo(String id, String name) async {
    final cachedId = _cache.getCachedDealId();

    if (cachedId != null && cachedId != id || cachedId == null) {
      // If for whatever reason getItemDealInfo throws an error then we're just
      // gonna let it bubble up since at this point the Item is different and
      // there is no point in returning the cached version.
      final deal = await _runners.getItemDealInfo(name);

      _cache.cacheDealInfo(id, deal);

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
    final request = ItemSearchRequestType(
      itemName: text,
      locale: _settings.language?.languageCode ?? 'en',
      platform: _settings.platform,
    );

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

  /// Only used for testing that runners throw the right exceptions.
  static WarframestatClient client([
    GamePlatforms platform = GamePlatforms.pc,
    SupportedLocale language = SupportedLocale.en,
  ]) {
    return WarframestatClient(platform: platform, language: language);
  }

  /// Returns an instance of [Worldstate]
  Future<Worldstate> getWorldstate(WorldstateRequestType request) async {
    final state = await compute(_getWorldstate, request);

    if (state == null) {
      throw const ServerException('Error in retriving worldstate.');
    }

    return state;
  }

  /// Returns a list of [SynthTarget]
  Future<List<SynthTarget>> getTargets() async {
    try {
      return await compute(_getTargets, null);
    } catch (e) {
      throw const ServerException('Error retriving targets.');
    }
  }

  /// Returns one instance of [Item], will throw [ItemNotFoundException] if
  /// it's unable to find a matching [Item] from [name].
  Future<Item> getItemDealInfo(String name) async {
    try {
      final deal = await compute(_getDealInfo, name);

      if (deal == null) {
        throw const ItemNotFoundException(
            'There is no information on this item');
      }

      return deal;
    } on ItemNotFoundException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        "Error retriving information on deal's item.",
      );
    }
  }

  /// Searchs for Items using the worldstate-status warframe-items endpoint in
  /// a seperate isolate
  Future<List<Item>> searchItems(ItemSearchRequestType request) {
    try {
      return compute(client(request.platform, request.language).searchItems,
          request.itemName);
    } on Exception {
      throw const ServerException('Error communication with APi.');
    }
  }

  static Future<Worldstate?> _getWorldstate(WorldstateRequestType request) {
    return client(request.platform, request.language).getWorldstate();
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    return client().getSynthTargets();
  }

  static Future<Item?> _getDealInfo(String name) async {
    final results = List<Item?>.from(await client().searchItems(name));

    return results
        .firstWhereOrNull((r) => r?.name.toLowerCase() == name.toLowerCase());
  }
}
// coverage: ignore-end
