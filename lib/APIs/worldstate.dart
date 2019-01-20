import 'dart:async';
import 'dart:convert';
import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorldstateAPI {
  String _platform;
  String _baseRoute = 'https://api.warframestat.us/';

  Future<WorldState> updateState() async {
    final prefs = await SharedPreferences.getInstance();
    _platform = prefs.getString('Platform') ?? 'pc';
    http.Response response = await http.get(_baseRoute + _platform);

    if (response.statusCode != 200) throw Exception();

    final data = json.decode(response.body);
    final key = KeyedArchive.unarchive(data);
    WorldState state = WorldState()..decode(key);

    await _cleanupState(state);
    return state;
  }

  static Future<List<Reward>> rewards() async {
    List<Reward> rewards = [];

    List<dynamic> url =
        json.decode((await http.get('http://142.93.23.157/rewards')).body);

    for (int i = 0; i < url.length; i++) {
      final key = KeyedArchive.unarchive(url[i]);
      final reward = Reward()..decode(key);
      rewards.add(reward);
    }

    return rewards;
  }

  Future<void> _cleanupState(WorldState state) async {
    //state.alerts.removeWhere((a) => a.expired == true);

    state.news.retainWhere((art) => art.translations.en != null);
    state.news.sort((a, b) => b.date.compareTo(a.date));

    state.invasions.retainWhere(
        (invasion) => invasion.completion < 100 && invasion.completed == false);

    state.syndicates.retainWhere((s) =>
        s.syndicate.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

    state.syndicates.sort((a, b) => a.syndicate.compareTo(b.syndicate));

    state.voidFissures.removeWhere((v) => v.active != true);
    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));
  }
}
