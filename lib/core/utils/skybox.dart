import 'package:flutter/widgets.dart';

class SkyBoxLoader {
  const SkyBoxLoader(this.context, this.node);

  final String node;

  // precacheImage requires access to BuildContext
  final BuildContext context;

  static const derelict = AssetImage('assets/skyboxes/Derelict.webp');

  Future<ImageProvider> load() async {
    final solNode = _getBackgroundPath();
    bool isError = false;

    if (solNode == 'undefined') return derelict;

    await precacheImage(
      AssetImage(solNode),
      context,
      onError: (dynamic e, stack) => isError = true,
    );

    return isError ? derelict : AssetImage(solNode);
  }

  String _getBackgroundPath() {
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return 'assets/skyboxes/${nodeBackground.replaceAll(' ', '_')}.webp';
  }
}
