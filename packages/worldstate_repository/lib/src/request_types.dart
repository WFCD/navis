import 'package:wfcd_client/wfcd_client.dart';

/// {@template request_type}
// ignore: comment_references
/// Creates a request with the values needed to pass to a [WarframeClient]
/// {@endtemplate}
abstract class RequestType {
  /// {@macro request_type}
  const RequestType({
    this.locale = 'en',
    this.platform = GamePlatforms.pc,
  });

  /// The language code the request is made for.
  final String locale;

  /// The Game platform this request is for.
  final GamePlatforms platform;

  /// Returns a supported language code.
  SupportedLocale get language {
    final locale = this.locale.split('_').first;
    return SupportedLocaleX.fromLocaleCode(locale);
  }
}

/// {@template worldstate_request}
/// Creates and instance of [WorldstateRequestType] in order to pass down to
/// compute runners.
///
// ignore: comment_references
/// See [compute]
/// {@endtemplate}
class WorldstateRequestType extends RequestType {
  /// {@macro worldstate_request}
  const WorldstateRequestType({
    required String locale,
    required GamePlatforms platform,
  }) : super(locale: locale, platform: platform);
}

/// {@template item_search_request}
/// Creates and instance of [WorldstateRequestType] in order to pass down to
/// compute runners.
///
// ignore: comment_references
/// See [compute]
/// {@endtemplate}
class ItemSearchRequestType extends RequestType {
  /// {@macro item_search_request}
  const ItemSearchRequestType({
    required this.itemName,
    required String locale,
    required GamePlatforms platform,
  }) : super(
          locale: locale,
          platform: platform,
        );

  /// The name of the item being searched for.
  final String itemName;
}
