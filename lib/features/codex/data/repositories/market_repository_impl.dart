import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:market_client/market_client.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/user_settings.dart';
import '../../../../core/network/network_info.dart';
import '../../domian/repositories/market_repository.dart';
import '../datasources/market_cache.dart';

class MarketRepositoryImpl extends MarketRepository {
  const MarketRepositoryImpl(this.networkInfo, this.usersettings, this.cache);

  final NetworkInfo networkInfo;
  final Usersettings usersettings;
  final MarketCache cache;

  @override
  Future<Result<List<ItemOrder>, Failure>> retriveOrders(
      String itemName) async {
    const _expiredCacheTime = Duration(minutes: 5);
    final cTimestamp = cache.getOrderTimestamp()?.difference(DateTime.now());
    final cItem = cache.getCachedItemName();

    Result<List<ItemOrder>, Failure> getcached() {
      final cached = cache.getCachedOrders();

      if (cached != null) {
        return Ok(cached);
      } else {
        return Err(CacheFailure());
      }
    }

    if (cItem != itemName &&
        (cTimestamp ?? _expiredCacheTime) <= _expiredCacheTime) {
      if (await networkInfo.isConnected) {
        final items = await getItems();

        final req = MarketRequest(
          itemUrl: itemName,
          languageCode: usersettings.language?.languageCode ?? 'en',
          platform: usersettings.platform,
          items: items.match((i) => i, (f) => throw CacheException()),
        );

        try {
          final orders = await compute(_retriveOrders, req);

          cache.cacheOrders(itemName, orders);
          return Ok(orders);
        } on SocketException {
          return Err(ServerFailure());
        }
      } else {
        return getcached();
      }
    } else {
      return getcached();
    }
  }

  Future<Result<List<MarketItem>, Failure>> getItems() async {
    const _expiredCacheTime = Duration(days: 7);
    final cTimestamp = cache.getItemsTimestamp();
    final cDuration =
        cTimestamp?.difference(DateTime.now()) ?? _expiredCacheTime;

    Result<List<MarketItem>, Failure> getcached() {
      final cached = cache.getCachedItems();

      if (cached != null) {
        return Ok(cached);
      } else {
        return Err(CacheFailure());
      }
    }

    if (cDuration >= _expiredCacheTime) {
      if (await networkInfo.isConnected) {
        final req = MarketRequest(
          languageCode: usersettings.language?.languageCode ?? 'en',
          platform: usersettings.platform,
        );

        try {
          final items = await compute(_getItems, req);

          cache.cacheItems(items);
          return Ok(items);
        } on SocketException {
          return getcached();
        }
      } else {
        return getcached();
      }
    } else {
      return getcached();
    }
  }

  static Future<List<ItemOrder>> _retriveOrders(MarketRequest req) async {
    final client = MarketHttpClient(
      platform: req.platform.marketPlatform,
      language: req.languageCode,
    );
    final api = MarketClient(client: client);
    final itemUrl =
        req.items.firstWhere((e) => e.itemName.contains(req.itemUrl!));

    return (await api.searchOrders(itemUrl.urlName)).sellOrders;
  }

  static Future<List<MarketItem>> _getItems(MarketRequest req) async {
    final client = MarketHttpClient(
      platform: req.platform.marketPlatform,
      language: req.languageCode,
    );
    final api = MarketClient(client: client);

    return api.getMarketItems();
  }
}

class MarketRequest {
  const MarketRequest({
    this.itemUrl,
    required this.languageCode,
    required this.platform,
    this.items = const <MarketItem>[],
  });

  final String? itemUrl;
  final String languageCode;
  final GamePlatforms platform;
  final List<MarketItem> items;
}

extension GamePlatformsX on GamePlatforms {
  MarketPlatform get marketPlatform {
    switch (this) {
      case GamePlatforms.pc:
        return MarketPlatform.pc;
      case GamePlatforms.ps4:
        return MarketPlatform.ps4;
      case GamePlatforms.xb1:
        return MarketPlatform.xbox;
      case GamePlatforms.swi:
        return MarketPlatform.swi;
    }
  }
}
