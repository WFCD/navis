import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:market_client/market_client.dart';
import 'package:market_repository/src/exceptions.dart';
import 'package:market_repository/src/helpers/market_request.dart';
import 'package:market_repository/src/market_cache.dart';
import 'package:user_settings/user_settings.dart';

/// {@template market_repo}
/// A repository to contact and cache request from Warframe market.
/// {@endtamplate}
class MarketRepository {
  /// {@macro market_repo}
  const MarketRepository({required this.usersettings, required this.cache});

  /// Instance of [UserSettings] in order to get updated on user's game platform
  /// and language.
  ///
  /// Will use english and PC as default values.
  final UserSettings usersettings;

  /// The caching layer for [MarketRepository]
  final MarketCache cache;

  /// Retrives a List of sell orders for a specfic item, also caches them in
  /// case the user checks out the same item twice. Invalidates the cache after
  /// 1 min for order accuracy.
  Future<List<OrderRow>> retriveOrders(String itemName) async {
    const _expiredCacheTime = Duration(minutes: 1);
    final cTimestamp = cache.ordersTimestamp?.difference(DateTime.now());
    final cItem = cache.cachedItemName;

    if (cItem != itemName &&
        (cTimestamp ?? _expiredCacheTime) <= _expiredCacheTime) {
      final req = MarketSearchRequest(
        itemUrl: itemName,
        languageCode: usersettings.language?.languageCode ?? 'en',
        platform: usersettings.platform,
        items: await getItems(),
      );

      try {
        final orders = await compute(MarketComputeRunners.searchOrders, req);
        cache.cacheOrders(itemName, orders.selling);

        return orders.selling;
      } on SocketException {
        final cached = cache.cachedOrders;

        if (cached == null) throw MarketServerException();

        return cached;
      }
    } else {
      final cached = cache.cachedOrders;

      if (cached == null) throw ItemsCacheException();

      return cached;
    }
  }

  // ignore: comment_references
  /// Returns a list of [MarketItem]s and caches them for one week.
  ///
  /// If there is no list in cache a request will be made, after all calls to
  /// this function will return from cache.
  Future<List<ItemShort>> getItems() async {
    const _expiredCacheTime = Duration(days: 7);
    final cTimestamp = cache.itemsTimestamp;
    final cDuration =
        cTimestamp?.difference(DateTime.now()) ?? _expiredCacheTime;

    if (cDuration >= _expiredCacheTime) {
      final req = MarketItemRequest(
        languageCode: usersettings.language?.languageCode ?? 'en',
        platform: usersettings.platform,
      );

      try {
        final items = await compute(MarketComputeRunners.getMarketItems, req);

        cache.cacheItems(items);
        return items;
      } on SocketException {
        final cached = cache.cachedItems;

        if (cached == null) rethrow;

        return cached;
      }
    } else {
      final cached = cache.cachedItems;

      if (cached == null) throw ItemsCacheException();

      return cached;
    }
  }
}

// coverage: ignore-start
/// {@template market_runners}
/// Hold the compute runners to get Warframe.market order information
///
/// Should not be used directly and is only visible for testing purposes.
/// [MarketRepository] uses this with caching.
/// {@endtemplate}
@visibleForTesting
class MarketComputeRunners {
  /// {@macro market_runner}
  const MarketComputeRunners._();

  /// Retrives a list of both sell and buy orders for an item.
  static Future<OrderSet<OrderRow>> searchOrders(MarketSearchRequest request) {
    return compute(_searchOrders, request);
  }

  /// Gets a list of market specific item information.
  static Future<List<ItemShort>> getMarketItems(MarketItemRequest request) {
    return compute(_getMarketItems, request);
  }

  static MarketClient _client(MarketPlatform platform, String languageCode) {
    final client = MarketHttpClient(platform: platform, language: languageCode);
    return MarketClient(client: client);
  }

  static Future<OrderSet<OrderRow>> _searchOrders(
      MarketSearchRequest req) async {
    final api = _client(req.marketPlatform, req.languageCode);

    final items = req.items;
    final itemUrl = items.firstWhere((e) => e.itemName.contains(req.itemUrl));

    return api.items.searchOrders(itemUrl.urlName);
  }

  static Future<List<ItemShort>> _getMarketItems(MarketItemRequest req) {
    final api = _client(req.marketPlatform, req.languageCode);
    return api.items.getMarketItems();
  }
}
// coverage: ignore-end
