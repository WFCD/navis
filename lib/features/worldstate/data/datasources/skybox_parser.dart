import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:navis/resources/resources.dart';

class SkyboxService {
  static const _baseUrl =
      'https://raw.githubusercontent.com/WFCD/navis/master/assets/skyboxes';

  static Map<String, List<String>> _skyboxData;

  static SkyboxService _instance;

  static Future<SkyboxService> loadSkyboxData() async {
    final data = await rootBundle.loadString(NavisAssets.skyboxNodes);

    _skyboxData ??= (json.decode(data) as Map<String, dynamic>)
        .map<String, List<String>>((key, dynamic value) =>
            MapEntry(key, (value as List<dynamic>).cast<String>()));

    return _instance ??= SkyboxService();
  }

  String getSkybox(String node) {
    final parsedNode = _parseNodePlanet(node);

    // ignore: missing_return
    final solNode = () {
      for (final key in _skyboxData.keys) {
        if (key == parsedNode || _skyboxData[key].contains(parsedNode)) {
          return '$_baseUrl/${key.replaceAll(' ', '_')}.webp';
        }
      }
    }();

    return solNode;
  }

  String _parseNodePlanet(String node) {
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return nodeBackground;
  }
}
