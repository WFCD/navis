import 'dart:convert';

import 'package:http/http.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

import '../base/remote/warframestate_remote_base.dart';
import '../constants/endpoints.dart';
import '../constants/supported_locales.dart';
import '../utils/json_utils.dart';

class WarframestatRemote implements WarframestatRemoteBase {
  WarframestatRemote(this.client);

  final Client client;

  @override
  Future<Worldstate> getWorldstate(GamePlatforms platform,
      {String language}) async {
    final path = platform.asString;
    final response = await _warframestat(path, language: language ?? 'en')
        as Map<String, dynamic>;

    return WorldstateModel.fromJson(response);
  }

  @override
  Future<List<BaseItem>> searchItems(String searchTerm) async {
    final term = searchTerm.toLowerCase();
    final response = await _warframestat('items/search/$term') as List<dynamic>;

    return toBaseItem(response);
  }

  @override
  Future<List<SynthTarget>> getSynthTargets() async {
    final response = await _warframestat('synthTargets') as List<dynamic>;

    return toSynthTargets(response);
  }

  Future<dynamic> _warframestat(String path, {String language = 'en'}) async {
    assert(supportedLocale.contains(language));
    final headers = <String, String>{'Accept-Language': language};
    final response =
        await client.get('$warframestatEndpoint/$path', headers: headers);

    return json.decode(response.body);
  }
}
