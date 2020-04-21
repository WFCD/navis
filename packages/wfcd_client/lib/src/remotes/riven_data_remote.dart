import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart' as http;
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

import '../../base.dart';
import '../base/remote/riven_data_remote_base.dart';
import '../constants/endpoints.dart';
import '../constants/supported_locales.dart';

class RivenDataRemote extends RivenDataRemoteBase {
  const RivenDataRemote({GamePlatforms platform}) : super(platform: platform);

  @override
  Future<Map<RivenType, Map<String, RivenData>>> getRivenData(
      {String language = 'en'}) async {
    assert(supportedLocale.contains(language));
    final _platform = platform.asString;

    final headers = <String, String>{'Accept-Language': language};
    final response = await http.get(
      '$warframestatEndpoint/$_platform/rivens',
      headers: headers,
    );

    return _toRivenData(json.decode(response.body) as Map<String, dynamic>);
  }

  Future<Map<RivenType, Map<String, RivenData>>> _toRivenData(
      Map<String, dynamic> data) async {
    return data.map((String key, dynamic data) {
      final type = RivenType.values.firstOrNullWhere(
          (t) => t.toString().contains(key.split(' ').first.toLowerCase()));
      final category = data as Map<String, dynamic>;

      return MapEntry(
        type,
        category.map((String key, dynamic data) {
          return MapEntry(
              key, RivenDataModel.fromJson(data as Map<String, dynamic>));
        }),
      );
    });
  }
}
