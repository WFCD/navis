import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/export.dart';
import '../resources/keys.dart';

class SystemState {
  String _platform;
  String _baseRoute = 'https://api.warframestat.us/';

  Future<WorldState> updateState() async {
    final prefs = await SharedPreferences.getInstance();
    _platform = prefs.getString('Platform') ?? 'pc';

    final data = json.decode((await http.get(_baseRoute + _platform)).body);
    final key = KeyedArchive.unarchive(data);
    WorldState state = WorldState()..decode(key);

    state.alerts.removeWhere((a) => a.expired == true);

    state.news.sort((a, b) => b.date.compareTo(a.date));
    state.news.retainWhere((art) => art.translations.en != null);

    state.invasions.retainWhere(
        (invasion) => invasion.completion < 100 && invasion.completed == false);

    state.syndicates
        .retainWhere((syndicate) => syndicate.syndicate == 'Ostrons');

    state.voidFissures.removeWhere((v) => v.expired == true);
    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

    return state;
  }

  static Future<String> fishVideos(String shortCode) async {
    final data = json.decode((await http.get(
            'https://api.streamable.com/videos/$shortCode',
            headers: {"email": streamableUser, "password": streamablePassword}))
        .body);

    return data['files']['mp4']['url'];
  }
}
