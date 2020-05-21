import 'dart:convert';

import 'package:http/http.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

enum GamePlatforms { pc, xb1, ps4, swi }

extension GamePlatformsX on GamePlatforms {
  String get asString => toString().split('.').last;
}

class WarframestatClient {
  WarframestatClient(this.client);

  final Client client;

  GamePlatforms platform = GamePlatforms.pc;
  String language = 'en';

  static const _baseUrl = 'https://api.warframestat.us';

  static const List<String> _supportedLocale = [
    'de',
    'es',
    'fr',
    'it',
    'ko',
    'pl',
    'pt',
    'ru',
    'zh',
    'en'
  ];

  Future<Worldstate> getWorldstate() async {
    final response =
        await _warframestat(platform.asString) as Map<String, dynamic>;

    return WorldstateModel.fromJson(response);
  }

  Future<List<BaseItem>> searchItems(String name) async {
    return _search<BaseItem>(name, 'items/search', toBaseItems);
  }

  Future<List<SlimDrop>> searchDrops(String name) async {
    return _search(name, 'drops/search', toDrops);
  }

  Future<List<RivenRoll>> searchRivens(String name) async {
    final term = name.toLowerCase();
    final response =
        await _warframestat('${platform.asString}/rivens/search/$term')
            as Map<String, dynamic>;

    return toRivens(name, response);
  }

  Future<List<T>> _search<T>(
    String term,
    String path,
    List<T> Function(List<dynamic>) toObject,
  ) async {
    final toSearch = term.toLowerCase();
    final response = await _warframestat('$path/$toSearch') as List<dynamic>;

    return toObject(response);
  }

  Future<List<SynthTarget>> getSynthTargets() async {
    final response = await _warframestat('synthTargets') as List<dynamic>;

    return toSynthTargets(response);
  }

  void updateLanguage(String language) => this.language = language;

  void updatePlatform(GamePlatforms platform) => this.platform = platform;

  Future<dynamic> _warframestat(String path) async {
    assert(_supportedLocale.contains(language));
    final headers = <String, String>{'Accept-Language': language};
    final response = await client.get('$_baseUrl/$path', headers: headers);

    return json.decode(response.body);
  }
}
