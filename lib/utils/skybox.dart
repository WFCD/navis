import 'package:flutter/widgets.dart';

class SkyBoxLoader {
  const SkyBoxLoader(this.context, this.node);

  final String node;

  // precacheImage requires access to BuildContext
  final BuildContext context;

  static const derelict = AssetImage('assets/skyboxes/Derelict.webp');

  ImageProvider load() {
    final solNode = _getBackgroundPath();
    bool isError = false;

    if (solNode == 'undefined') return derelict;

    _checkBackground().then((data) => isError = data);

    return isError ? derelict : AssetImage(solNode);
  }

  Future<bool> _checkBackground() async {
    bool doesBackgroundExist = true;

    await precacheImage(
      AssetImage(node),
      context,
      onError: (dynamic e, stack) => doesBackgroundExist = false,
    );

    return doesBackgroundExist;
  }

  String _getBackgroundPath() {
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return 'assets/skyboxes/${nodeBackground.replaceAll(' ', '_')}.webp';
  }
}
