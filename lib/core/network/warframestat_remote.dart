import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';

enum GamePlatforms { pc, xb1, ps4, swi }

class WarframestatClient {
  WarframestatClient(this.client);

  final Client client;

  static const _baseUrl = 'https://api.warframestat.us';

  Future<Worldstate> getWorldstate(GamePlatforms platform) async {
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

  Future<List<RivenRoll>> searchRivens(String name,
      {GamePlatforms platform = GamePlatforms.pc}) async {
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

  Future<dynamic> _warframestat(String path) async {
    final language = Intl.getCurrentLocale() ?? 'en';
    final headers = <String, String>{'Accept-Language': language};
    final response = await client.get('$_baseUrl/$path', headers: headers);

    return json.decode(response.body);
  }
}

extension GamePlatformsX on GamePlatforms {
  String get asString => toString().split('.').last;

  static GamePlatforms fromString(String value) {
    return GamePlatforms.values.firstWhere(
      (element) => element.toString().contains(value),
      orElse: () => null,
    );
  }
}
