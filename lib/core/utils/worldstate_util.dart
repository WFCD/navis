import 'package:worldstate_api_model/worldstate_models.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.removeWhere((a) {
    return a.active == false ||
        a.expiry.difference(DateTime.now().toUtc()) <=
            const Duration(seconds: 1);
  });

  state.dailyDeals.retainWhere((d) {
    return d.total - d.sold > 0 ||
        d.expiry.difference(DateTime.now()) > const Duration(seconds: 60);
  });

  state.news.retainWhere((art) => art.translations['en'] != null);
  state.news.sort((a, b) => b.date.compareTo(a.date));

  // state.invasions.retainWhere(
  //     (invasion) => invasion.completion < 100 && invasion.completed == false);

  state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

  state.syndicateMissions.retainWhere(
      (s) => s.name.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

  state.syndicateMissions.sort((a, b) => a.name.compareTo(b.name));

  // state.fissures.removeWhere((v) =>
  //     v.active == false ||
  //     v.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.fissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

  return state;
}
