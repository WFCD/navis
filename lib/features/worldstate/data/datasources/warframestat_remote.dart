import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/localizations.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WarframestatRemoteBase {
  Future<List<SynthTarget>> getSynthTargets();

  Future<Worldstate> getWorldstate(GamePlatforms platform);

  Future<List<BaseItem>> searchItems(String term);
}

enum GamePlatforms { pc, ps4, xb1, swi }

class WarframestatRemote implements WarframestatRemoteBase {
  final http.Client client;

  const WarframestatRemote(this.client);

  static const _baseUrl = 'https://api.warframestat.us';

  @override
  Future<List<SynthTarget>> getSynthTargets() async {
    final data = await _baseCaller('/synthTargets');

    return compute<String, List<SynthTarget>>(toTargets, data);
  }

  @override
  Future<Worldstate> getWorldstate(GamePlatforms platform) async {
    final data = await _baseCaller('/${platform.platformToString()}');

    return compute<String, Worldstate>(toWorldstate, data);
  }

  @override
  Future<List<BaseItem>> searchItems(String term) async {
    final results = await _baseCaller('/items/search/${term.toLowerCase()}');

    return compute<String, List<BaseItem>>(toBaseItems, results);
  }

  Future<String> _baseCaller(String path) async {
    final response = await client.get(
      '$_baseUrl$path',
      headers: {
        'Accept-Language': NavisLocalizations.current?.localeName ?? 'en'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
