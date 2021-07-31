import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:market_client/market_client.dart';

class MarketCache {
  const MarketCache._(this._box);

  final Box<dynamic> _box;

  static MarketCache? _instance;

  static Future<MarketCache> initCache() async {
    log('Initializing MarketCache Hive');
    final box = await Hive.openBox<dynamic>('market_cache').catchError(
      (Object error, StackTrace stack) {
        log('Unable to open Hive box', error: error, stackTrace: stack);
      },
    );

    return _instance ??= MarketCache._(box);
  }

  static const _itemsTimestamp = 'marketItemTimestampe';
  static const _marketItems = 'marketItems';
  static const _orderTimestamp = 'orderTimestamp';
  static const _itemName = 'itemName';
  static const _ordersKey = 'marketOrders';

  void cacheItems(List<MarketItem> items) {
    _box
      ..put(_itemsTimestamp, DateTime.now())
      ..put(_marketItems, items.map((e) => e.toJson()).toList());
  }

  void cacheOrders(String itemName, List<ItemOrder> orders) {
    _box
      ..put(_orderTimestamp, DateTime.now())
      ..put(_itemName, itemName)
      ..put(_ordersKey, orders.map((o) => o.toJson()).toList());
  }

  DateTime? getItemsTimestamp() {
    return _box.get(_itemsTimestamp);
  }

  String? getCachedItemName() {
    return _box.get(_itemName);
  }

  DateTime? getOrderTimestamp() {
    return _box.get(_orderTimestamp);
  }

  List<ItemOrder>? getCachedOrders() {
    final cached = _box.get(_ordersKey) as List<Map<String, dynamic>>?;

    if (cached != null) {
      return cached.map((e) => ItemOrder.fromJson(e)).toList();
    }

    return null;
  }

  List<MarketItem>? getCachedItems() {
    final cached = _box.get(_marketItems) as List<Map<String, dynamic>>?;

    if (cached != null) {
      return cached.map((e) => MarketItem.fromJson(e)).toList();
    }
  }
}
