// ignore_for_file: deprecated_member_use

import 'package:market_client/market_client.dart';
import 'package:warframestat_client/warframestat_client.dart';

/// {@template search_request}
/// Creates a search request instance to send to MarketClient compute runners.
/// {@endtemplate}
typedef MarketSearchRequest = (
  /// Warframe Market has it's own item database and requires it's own url for
  /// items.
  String itemUrl,

  /// The game platform the request is for.
  GamePlatform platform,

  /// The language to return results in.
  String languageCode,

  /// A list of market items.
  ///
  /// Because there are a lot of items and we need to pass down a list to a
  /// compute in order to look for the [itemUrl] without stalling the UI thread.
  List<ItemShort> items,
);

/// {@template item_request}
/// Create an item request to retrive market item's specific information.
/// {@endtemplate}
typedef MarketItemRequest = (GamePlatform, String);

extension GamePlatformX on GamePlatform {
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
