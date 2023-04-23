// ignore_for_file: deprecated_member_use

import 'package:market_client/market_client.dart';
import 'package:warframestat_client/warframestat_client.dart';

/// {@template search_request}
/// Creates a search request instance to send to MarketClient compute runners.
/// {@endtemplate}
class MarketSearchRequest {
  /// {@macro search_request}
  const MarketSearchRequest({
    required this.itemUrl,
    required this.languageCode,
    required this.platform,
    required this.items,
  });

  /// Warframe Market has it's own item database and requires it's own url for
  /// items.
  final String itemUrl;

  /// The game platform the request is for.
  final GamePlatform platform;

  /// The language to return results in.
  final String languageCode;

  /// A list of market items.
  ///
  /// Because there are a lot of items and we need to pass down a list to a
  /// compute in order to look for the [itemUrl] without stalling the UI thread.
  final List<ItemShort> items;

  /// Returns a [MarketPlatform] equivalent of [GamePlatforms]
  MarketPlatform get marketPlatform => platform.marketPlatform;
}

/// {@template item_request}
/// Create an item request to retrive market item's specific information.
/// {@endtemplate}
class MarketItemRequest {
  /// {@macro item_request}
  const MarketItemRequest({required this.platform, required this.languageCode});

  /// The game platform the request is for.
  final GamePlatform platform;

  /// The language to return results in.
  final String languageCode;

  /// Returns a [MarketPlatform] equivalent of [GamePlatforms]
  MarketPlatform get marketPlatform => platform.marketPlatform;
}

extension on GamePlatform {
  /// Returns a [MarketPlatform] equivalent of [GamePlatforms]
  MarketPlatform get marketPlatform {
    switch (this) {
      case GamePlatform.pc:
        return MarketPlatform.pc;
      case GamePlatform.ps4:
        return MarketPlatform.ps4;
      case GamePlatform.xb1:
        return MarketPlatform.xbox;
      case GamePlatform.swi:
        return MarketPlatform.swi;
    }
  }
}
