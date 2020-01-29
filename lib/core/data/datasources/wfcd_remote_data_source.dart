import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WfcdRemoteDataSource {
  Future<List<SynthTarget>> getSynthTargets();

  Future<Worldstate> getWorldstate(Platforms platform);

  Future<List<BaseItem>> searchItems(String term);
}

class WfcdClient implements WfcdRemoteDataSource {
  final http.Client client;

  const WfcdClient(this.client);

  static const _baseUrl = 'https://api.warframestat.us';

  @override
  Future<List<SynthTarget>> getSynthTargets() async {
    final data = await _baseCaller('/synthTargets');

    return compute<String, List<SynthTarget>>(toTargets, data);
  }

  @override
  Future<Worldstate> getWorldstate(Platforms platform) async {
    final data = await _baseCaller('/${platform.platformToString()}');

    return compute<String, Worldstate>(toWorldstate, data);
  }

  @override
  Future<List<BaseItem>> searchItems(String term) async {
    final results = await _baseCaller('/items/search/${term.toLowerCase()}');

    return compute<String, List<BaseItem>>(toBaseItems, results);
  }

  Future<String> _baseCaller(String path) async {
    final response = await client.get('$_baseUrl$path');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
