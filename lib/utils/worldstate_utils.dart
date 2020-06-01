import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/objects.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.removeWhere((a) =>
      a.active == false ||
      a.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.news.retainWhere(
      (art) => art.translations[Intl.getCurrentLocale() ?? 'en'] != null);
  state.news.sort((a, b) => b.date.compareTo(a.date));

  state.invasions.retainWhere(
      (invasion) => invasion.completion < 100 && invasion.completed == false);

  state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

  state.syndicateMissions.retainWhere((s) => s.jobs?.isNotEmpty ?? false);

  state.syndicateMissions.sort((a, b) => a.name.compareTo(b.name));

  state.fissures.removeWhere((v) =>
      v.active == false ||
      v.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.fissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

  return state;
}

bool compareIds(
    List<WorldstateObject> previous, List<WorldstateObject> current) {
  if (current == null) return false;

  const _deep = DeepCollectionEquality();

  final previousIds = previous?.map<String>((w) => w.id);
  final currentIds = current.map<String>((w) => w.id);

  return !_deep.equals(previousIds ?? [], currentIds);
}
