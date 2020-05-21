import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class SkyBoxLoader {
  const SkyBoxLoader(this.context, this.node);

  final String node;

  // precacheImage requires access to BuildContext
  final BuildContext context;

  static const _baseUrl =
      'https://raw.githubusercontent.com/WFCD/navis/n2.0/assets/skyboxes';

  static const derelict = AssetImage('assets/Derelict.webp');

  Future<ImageProvider> load() async {
    final solNode = _getBackgroundPath();
    bool isError = false;

    if (solNode == 'undefined') return derelict;

    await precacheImage(
      CachedNetworkImageProvider(solNode),
      context,
      onError: (dynamic e, stack) => isError = true,
    );

    if (isError) {
      return derelict;
    } else {
      return CachedNetworkImageProvider(solNode);
    }
  }

  String _getBackgroundPath() {
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return '$_baseUrl/${nodeBackground.replaceAll(' ', '_')}.webp';
  }
}
