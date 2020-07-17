import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/resources/resources.dart';

class SkyboxService {
  static const _baseUrl =
      'https://raw.githubusercontent.com/WFCD/navis/master/assets/skyboxes';

  static const derelict = AssetImage(Resources.derelictSkybox);

  static Map<String, List<String>> _skyboxData;

  static SkyboxService _instance;

  static Future<SkyboxService> loadSkyboxData() async {
    final data = await rootBundle.loadString(Resources.skyboxNodes);

    _skyboxData ??= (json.decode(data) as Map<String, dynamic>)
        .map<String, List<String>>((key, dynamic value) =>
            MapEntry(key, (value as List<dynamic>).cast<String>()));

    return _instance ??= SkyboxService();
  }

  Future<ImageProvider> getSkybox(BuildContext context, String node) async {
    final parsedNode = _parseNodePlanet(node);
    final containsNode = _skyboxData.containsKey(parsedNode) ||
        _skyboxData.containsValue(parsedNode);

    if (!containsNode) return derelict;

    try {
      String solNode;

      for (final key in _skyboxData.keys) {
        if (key == parsedNode || _skyboxData[key].contains(parsedNode)) {
          solNode = '$_baseUrl/${key.replaceAll(' ', '_')}.webp';
          break;
        }
      }

      final image = CachedNetworkImageProvider(solNode);
      await precacheImage(image, context);

      return image;
    } catch (e) {
      return derelict;
    }
  }

  String _parseNodePlanet(String node) {
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return nodeBackground;
  }
}
