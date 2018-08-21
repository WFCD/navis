import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;
import 'package:navis/util/preferences.dart';

import '../json/export.dart';
import '../util/keys.dart';

class SystemState {
  String _platform;
  String _baseRoute = 'https://api.warframestat.us/';

  SystemState();

  Future _loadPlatform() async {
    final prefs = Preferences();
    final platform = await prefs.getPlatform();

    if (platform == null) {
      prefs.firstRun();
      _platform = await prefs.getPlatform();
    } else {
      return _platform = platform;
    }
  }

  Future<WorldState> updateState() async {
    await _loadPlatform();
    final data = json.decode((await http.get(_baseRoute + _platform)).body);
    final key = KeyedArchive.unarchive(data);
    WorldState state = WorldState()..decode(key);

    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

    state.news.sort((a, b) => b.date.compareTo(a.date));

    state.news.retainWhere((art) => art.translations.en != null);

    state.invasions.retainWhere(
        (invasion) => invasion.completion < 100 && invasion.completed == false);

    state.syndicates
        .retainWhere((syndicate) => syndicate.syndicate == 'Ostrons');

    return state;
  }

  static Future<String> rewardImages(String reward) async {
    var url;
    try {
      url = json.decode(
          (await http.get('http://35.196.173.46/rewards/$reward')).body);
    } catch (err) {
      url = {"path": "https://i.imgur.com/LuVQFbh.png"};
    }

    final key = KeyedArchive.unarchive(url);
    final rewards = Rewards()..decode(key);

    return rewards.path;
  }

  static Future<String> rewardColor(String reward) async {
    var url;
    try {
      url = json.decode(
          (await http.get('http://35.196.173.46/rewards/$reward')).body);
    } catch (err) {
      url = {"level": ""};
    }

    final key = KeyedArchive.unarchive(url);
    final rewards = Rewards()..decode(key);

    return rewards.level;
  }

  static Future<String> fishVideos(String shortCode) async {
    final data = json.decode((await http.get(
            'https://api.streamable.com/videos/$shortCode',
            headers: {"email": streamableUser, "password": streamablePassword}))
        .body);

    return data['files']['mp4']['url'];
  }
}
