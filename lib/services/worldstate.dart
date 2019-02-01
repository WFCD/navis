import 'dart:async';
import 'dart:convert';
import 'package:codable/codable.dart';
import 'package:http/http.dart';
import 'package:navis/models/export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navis/utils/metric_httpClient.dart';

class WorldstateAPI {
  final String _baseRoute = 'https://api.warframestat.us/';

  static final MetricHttpClient _metricHttpClient = MetricHttpClient(Client());

  Future<WorldState> updateState() async {
    final prefs = await SharedPreferences.getInstance();
    final Request request = Request(
        'GET', Uri.parse('$_baseRoute${prefs.getString('Platform') ?? 'pc'}'));

    final StreamedResponse response = await _metricHttpClient.send(request);

    if (response.statusCode != 200) throw Exception('error loading state');

    final data =
        json.decode(await response.stream.transform(utf8.decoder).join());

    final key = KeyedArchive.unarchive(data);
    final WorldState state = WorldState()..decode(key);

    _cleanState(state);
    return state;
  }

  static Future<List<Reward>> rewards() async {
    final Request request =
        Request('GET', Uri.parse('http://142.93.23.157/rewards'));

    final StreamedResponse response = await _metricHttpClient.send(request);

    return await response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((r) => r)
        .map((r) => Reward()..decode(KeyedArchive.unarchive(r)))
        .toList();
  }

  void _cleanState(WorldState state) {
    state.alerts.removeWhere((a) =>
        a.active == false ||
        a.expiry.difference(DateTime.now().toUtc()) < Duration(seconds: 1));

    state.news.retainWhere((art) => art.translations.en != null);
    state.news.sort((a, b) => b.date.compareTo(a.date));

    state.invasions.retainWhere(
        (invasion) => invasion.completion < 100 && invasion.completed == false);

    state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

    state.syndicates.retainWhere((s) =>
        s.syndicate.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

    state.syndicates.sort((a, b) => a.syndicate.compareTo(b.syndicate));

    state.voidFissures.removeWhere((v) =>
        v.active == false ||
        v.expiry.difference(DateTime.now().toUtc()) < Duration(seconds: 1));

    state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));
  }
}
