import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:market_client/market_client.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/wfcd_client.dart';

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
    final cItem = cache.getCachedItemName();

    Result<List<ItemOrder>, Failure> getcached() {
      final cached = cache.getCachedOrders();

      if (cached != null) {
        return Ok(cached);
      } else {
        return Err(CacheFailure());
      }
    }

    if (cItem != itemName) {
      if (await networkInfo.isConnected) {
        final req = MarketRequest(usersettings.language?.languageCode ?? 'en',
            itemName, usersettings.platform);

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

  static Future<List<ItemOrder>> _retriveOrders(MarketRequest req) async {
    final client = MarketHttpClient(
      platform: req.platform.marketPlatform,
      language: req.languageCode,
    );
    final api = MarketClient(client: client);
    final itemUrl = (await api.getMarketItems())
        .firstWhere((e) => e.itemName.contains(req.itemUrl));

    return await api.searchOrders(itemUrl.urlName);
  }
}

class MarketRequest {
  const MarketRequest(this.itemUrl, this.languageCode, this.platform);

  final String itemUrl;
  final String languageCode;
  final GamePlatforms platform;
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
