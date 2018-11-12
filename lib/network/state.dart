import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    state.syndicates.sort((a, b) => a.syndicate.compareTo(b.syndicate));
    state.syndicates.retainWhere(
            (syndicate) => _syndicateCheck(syndicate.syndicate) == true);

    state.voidFissures.removeWhere((v) => v.expired == true);
    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

    return state;
  }

  static Future<Reward> rewards(String item) async {
    Map<String, dynamic> url = json
        .decode((await http.get('http://142.93.23.157/rewards/$item')).body);

    final key = KeyedArchive.unarchive(url);
    final reward = Reward()
      ..decode(key);

    return reward;
  }

  static Future<String> fishVideos(String shortCode) async {
    final data = json.decode((await http.get(
            'https://api.streamable.com/videos/$shortCode',
            headers: {"email": streamableUser, "password": streamablePassword}))
        .body);

    return data['files']['mp4']['url'];
  }

  bool _syndicateCheck(String syndicate) {
    switch (syndicate) {
      case 'Ostrons':
        return true;
      case 'Solaris United':
        return true;
      default:
        return false;
    }
  }
}
