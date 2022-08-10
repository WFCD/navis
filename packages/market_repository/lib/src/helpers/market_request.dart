import 'package:market_client/market_client.dart';
import 'package:wfcd_client/wfcd_client.dart';

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
  final GamePlatforms platform;

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
  final GamePlatforms platform;

  /// The language to return results in.
  final String languageCode;

  /// Returns a [MarketPlatform] equivalent of [GamePlatforms]
  MarketPlatform get marketPlatform => platform.marketPlatform;
}

extension on GamePlatforms {
  /// Returns a [MarketPlatform] equivalent of [GamePlatforms]
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
