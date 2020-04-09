import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/enums.dart';
import 'package:wfcd_client/src/utils/json_utils.dart';
import 'package:wfcd_client/src/utils/supported_locales.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

class WorldstateClient {
  const WorldstateClient();

  static const String _baseUrl = 'https://api.warframestat.us';

  Future<Worldstate> getWorldstate(Platforms platform,
      {String language = 'en'}) async {
    final path = platformToString(platform);
    final response =
        await _warframestat(path, language: language) as Map<String, dynamic>;

    return WorldstateModel.fromJson(response);
  }

  Future<List<BaseItem>> searchItems(String searchTerm) async {
    final term = searchTerm.toLowerCase();
    final response = await _warframestat('items/search/$term') as List<dynamic>;

    return toBaseItem(response);
  }

  Future<List<SynthTarget>> synthTargets() async {
    final response = await _warframestat('synthTargets') as List<dynamic>;

    return toSynthTargets(response);
  }

  Future<dynamic> _warframestat(String path, {String language = 'en'}) async {
    assert(supportedLocale.contains(language));
    final headers = <String, String>{'Accept-Language': language};
    final response = await http.get('$_baseUrl/$path', headers: headers);

    return json.decode(response.body);
  }
}
