import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:market_client/market_client.dart';

/// {@template market_cache}
// ignore: comment_references
/// Caching layer for [MarketRepository]
/// {@endtemplate}
class MarketCache {
  const MarketCache._(this._box);

  final Box<dynamic> _box;

  static MarketCache? _instance;

  /// Initiates caching [Box] for market cache
  static Future<MarketCache> initCache(String path) async {
    log('Initializing MarketCache Hive');
    final box = await Hive.openBox<dynamic>('market_cache', path: path);

    return _instance ??= MarketCache._(box);
  }

  static const _itemsTimestamp = 'marketItemTimestampe';
  static const _marketItems = 'marketItems';
  static const _orderTimestamp = 'orderTimestamp';
  static const _itemName = 'itemName';
  static const _ordersKey = 'marketOrders';

  /// Caches the market item list for later use.
  ///
  /// Also caches a timestamp of the date it was cached for cache invalidation.
  void cacheItems(List<MarketItem> items) {
    _box
      ..put(_itemsTimestamp, DateTime.now())
      ..put(_marketItems, items.map((e) => e.toJson()).toList());
  }

  /// Caches the list of orders for a specific item.
  ///
  /// Also caches the item's name, and a timestamp of when it was cached.
  void cacheOrders(String itemName, List<ItemOrder> orders) {
    _box
      ..put(_orderTimestamp, DateTime.now())
      ..put(_itemName, itemName)
      ..put(_ordersKey, orders.map((o) => o.toJson()).toList());
  }

  /// Gets the timestamp the market items were last cached at.
  DateTime? get itemsTimestamp => _box.get(_itemsTimestamp) as DateTime?;

  /// Gets the cached item name that was used to search orders.
  String? get cachedItemName => _box.get(_itemName) as String?;

  /// Gets the timestamp the sell orders were cached.
  DateTime? get ordersTimestamp => _box.get(_orderTimestamp) as DateTime?;

  /// Returns all cached sell orders.
  List<ItemOrder>? get cachedOrders {
    final cached = _box.get(_ordersKey) as List<Map<String, dynamic>>?;

    if (cached != null) {
      return cached.map((e) => ItemOrder.fromJson(e)).toList();
    }

    return null;
  }

  /// Returns all cached market items.
  List<MarketItem>? get cachedItems {
    final cached = _box.get(_marketItems) as List<Map<String, dynamic>>?;

    if (cached != null) {
      return cached.map((e) => MarketItem.fromJson(e)).toList();
    }

    return <MarketItem>[];
  }
}
