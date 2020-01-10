import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:worldstate_api_model/worldstate_models.dart';
import 'package:worldstate_api_model/worldstate_objects.dart';

import 'enums.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.removeWhere((a) =>
      a.active == false ||
      a.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.dailyDeals.retainWhere((d) {
    return d.total - d.sold > 0 ||
        d.expiry.difference(DateTime.now()) > const Duration(seconds: 60);
  });

  state.news.retainWhere((art) => art.translations['en'] != null);
  state.news.sort((a, b) => b.date.compareTo(a.date));

  state.invasions.retainWhere(
      (invasion) => invasion.completion < 100 && invasion.completed == false);

  state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

  state.syndicateMissions.retainWhere(
      (s) => s.name.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

  state.syndicateMissions.sort((a, b) => a.name.compareTo(b.name));

  state.fissures.removeWhere((v) =>
      v.active == false ||
      v.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.fissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

  return state;
}

String _getBackgroundPath(String node) {
  final nodeRegExp = RegExp(r'\(([^)]*)\)');
  final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

  return 'assets/skyboxes/${nodeBackground.replaceAll(' ', '_')}.webp';
}

Future<ImageProvider> skybox(BuildContext context, String node) async {
  const derelict = AssetImage('assets/skyboxes/Derelict.webp');
  final solNode = _getBackgroundPath(node);
  bool doesBackgroundExist = true;

  if (solNode == 'undefined') return derelict;

  await precacheImage(
    AssetImage(solNode),
    context,
    onError: (e, stack) => doesBackgroundExist = false,
  );

  return doesBackgroundExist ? AssetImage(solNode) : derelict;
}

bool compareIds(
    List<WorldstateObject> previous, List<WorldstateObject> current) {
  if (current == null) return false;

  const _deep = DeepCollectionEquality();

  final previousIds = previous?.map<String>((w) => w.id);
  final currentIds = current.map<String>((w) => w.id);

  return !_deep.equals(previousIds ?? [], currentIds);
}

DateFormat enumToDateformat(Formats format) {
  switch (format) {
    case Formats.dd_mm_yy:
      return DateFormat('hh:mm:ss dd/MM/yyyy');
      break;
    case Formats.month_day_year:
      return DateFormat.yMMMMd('en_US').add_jms();
    default:
      return DateFormat.jms().add_yMd();
  }
}
