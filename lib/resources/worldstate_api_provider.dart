import 'dart:convert';

import 'package:navis/utils/enums.dart';
import 'package:navis/utils/helper_methods.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';
import 'package:http/http.dart' as http;

class WorldstateApiProvider {
  const WorldstateApiProvider();

  static const String _baseUrl = 'api.warframestat.us';

  Future<Worldstate> getWorldstate(Platforms platform) async {
    final path = platformToString(platform);
    final response = await _warframestat(path);

    return Worldstate.fromJson(json.decode(response) as Map<String, dynamic>);
  }

  Future<List<ItemObject>> searchItems(String searchTerm) async {
    final term = searchTerm.toLowerCase();
    final response = await _warframestat('items/search/$term');

    return jsonToItemObjects(response);
  }

  Future<List<SynthTarget>> synthTargets() async {
    final response = await _warframestat('synthTargets');

    return jsonToTargets(response);
  }

  Future<String> _warframestat(String path) async {
    final response = await http.get('$_baseUrl/$path');

    return response.body;
  }
}
