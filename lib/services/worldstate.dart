import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';

import 'package:navis/models/export.dart';
import 'package:http/http.dart' as http;

class WorldstateAPI {
  static const String _baseRoute = 'https://api.warframestat.us/';

  Future<WorldState> getWorldstate(
      [http.Client client, String platform]) async {
    client ??= http.Client();
    platform ??= 'pc';

    final response = await client.get(_baseRoute + platform);

    if (response.statusCode != 200)
      throw Exception('Error connecting: ${response.statusCode}');

    final data = json.decode(response.body);

    final key = KeyedArchive.unarchive(data);
    final WorldState state = WorldState()..decode(key);

    _cleanState(state);
    return state;
  }

  void _cleanState(WorldState state) {
    state.alerts.removeWhere((a) =>
        a.active == false ||
        a.expiry.difference(DateTime.now().toUtc()) <
            const Duration(seconds: 1));

    state.news.retainWhere((art) => art.translations.en != null);
    state.news.sort((a, b) => b.date.compareTo(a.date));

    state.invasions.retainWhere(
        (invasion) => invasion.completion < 100 && invasion.completed == false);

    state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

    state.syndicates.retainWhere(
        (s) => s.name.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

    state.syndicates.sort((a, b) => a.name.compareTo(b.name));

    state.voidFissures.removeWhere((v) =>
        v.active == false ||
        v.expiry.difference(DateTime.now().toUtc()) <
            const Duration(seconds: 1));

    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));
  }
}
