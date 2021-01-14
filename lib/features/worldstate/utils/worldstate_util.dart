import 'package:wfcd_client/entities.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.retainWhere((e) => e.active);

  state.dailyDeals.retainWhere((e) => (e.total - e.sold) > 0);

  state.news.sort((a, b) => b.date.compareTo(a.date));

  state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

  state.syndicateMissions
    ..retainWhere((s) => s.jobs?.isNotEmpty ?? false)
    ..sort((a, b) => a.name.compareTo(b.name));

  state.fissures
    ..retainWhere((e) => !e.expired)
    ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

  state.invasions.retainWhere((e) => !e.completed);

  return state;
}
