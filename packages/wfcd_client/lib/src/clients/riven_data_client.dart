import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:wfcd_client/enums.dart';
import 'package:wfcd_client/src/utils/json_utils.dart';
import 'package:dartx/dartx.dart';
import 'package:wfcd_client/src/utils/supported_locales.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

enum RivenType { archgun, kitgun, melee, pistol, rifle, shotgun, zaw }

class RivenDataClient extends Equatable {
  const RivenDataClient(this.path, {this.platform = Platforms.pc});

  final String path;
  final Platforms platform;

  static const _baseUrl = 'https://api.warframestat.us';

  File get rivenData {
    return File('$path/riven_data_${platformToString(platform)}');
  }

  Future<void> downloadRivenData({String language = 'en'}) async {
    assert(supportedLocale.contains(language));
    final _platform = platformToString(platform);

    final headers = <String, String>{'Accept-Language': language};
    final response =
        await http.get('$_baseUrl/$_platform/rivens', headers: headers);

    await rivenData.writeAsString(response.body);
  }

  Future<RivenData> getArchgunRivenData(String key) async {
    final archguns = await getCategoryRivenData(RivenType.archgun);

    return archguns[key];
  }

  Future<RivenData> getKitgunRivenData(String key) async {
    final kitguns = await getCategoryRivenData(RivenType.kitgun);

    return kitguns[key];
  }

  Future<RivenData> getMeleeRivenData(String key) async {
    final melees = await getCategoryRivenData(RivenType.melee);

    return melees[key];
  }

  Future<RivenData> getPistolRivenData(String key) async {
    final pistols = await getCategoryRivenData(RivenType.pistol);

    return pistols[key];
  }

  Future<RivenData> getRifleRivenData(String key) async {
    final rifles = await getCategoryRivenData(RivenType.rifle);

    return rifles[key];
  }

  Future<RivenData> getShotgunRivenData(String key) async {
    final shotguns = await getCategoryRivenData(RivenType.shotgun);

    return shotguns[key];
  }

  Future<RivenData> getZawRivenData(String key) async {
    final zaws = await getCategoryRivenData(RivenType.zaw);

    return zaws[key];
  }

  Future<Map<String, RivenData>> getCategoryRivenData(RivenType type) async {
    final data = await getAllRivens();

    return data[type];
  }

  Future<Map<RivenType, Map<String, RivenData>>> getAllRivens() async {
    if (!rivenData.existsSync()) await downloadRivenData();

    final file = await rivenData.readAsString();
    final data = json.decode(file) as Map<String, dynamic>;

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

  @override
  List<Object> get props => [path, platform];
}
