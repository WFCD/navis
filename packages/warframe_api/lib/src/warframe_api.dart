import 'dart:convert';
import 'dart:isolate';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';

typedef WorldstateLocale = WorldstateDataLocale;

/// {@template warframe_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeApi {
  /// {@macro warframe_api}
  const WarframeApi({required Client client}) : _client = client;

  final Client _client;

  Future<Worldstate> fetchWorldstate(DropData data, [WorldstateLocale locale = .en]) async {
    final res = await _client.get(Uri.parse(_worldstateApi));
    final body = res.body;

    return Isolate.run(() {
      final raw = RawWorldstate.fromJson(body);
      final deps = Dependency(locale: locale, dropData: data);
      return raw.toWorldstate(deps);
    });
  }

  Future<DropData> fetchDropData() async {
    final res = await _client.get(Uri.parse(warframeDropDataPage));
    final raw = res.bodyBytes;

    return Isolate.run(() async {
      final html = parse(raw, encoding: 'urf-8');
      return buildDropData(html.body!);
    });
  }

  Future<Profile> fetchProfile(String id) async {
    final res = await _client.get(Uri.parse('$_profileApi?playerId=$id'));
    final body = res.body;

    return Isolate.run(() {
      final json = jsonDecode(body) as Map<String, dynamic>;
      return RawProfile.fromMap((json['Results'] as List<dynamic>).first as Map<String, dynamic>).toProfile();
    });
  }

  bool verifyUserData(String data) {
    try {
      final sanitized = const LineSplitter().convert(data).join();
      final json = jsonDecode(sanitized) as Map<String, dynamic>;

      // These fields don't exist if the user is logged off
      return json.containsKey('user_id') || json.containsKey('account');
    } on FormatException {
      return false;
    }
  }
}
