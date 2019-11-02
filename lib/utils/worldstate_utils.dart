import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:navis/services/storage/dateformat_enum.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_model/worldstate_models.dart';
import 'package:worldstate_model/worldstate_objects.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.removeWhere((a) =>
      a.active == false ||
      a.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

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

List<Drop> jsonToRewards(String response) {
  final drops = json.decode(response).cast<Map<String, dynamic>>();

  return drops.map<Drop>((d) => Drop.fromJson(d)).toList();
}

Future<bool> _checkBackground(BuildContext context, String node) async {
  bool doesBackgroundExist = true;

  if (node == null || node == 'undefined') return false;

  await precacheImage(
    AssetImage(_getBackgroundPath(node)),
    context,
    onError: (e, stack) => doesBackgroundExist = false,
  );

  return doesBackgroundExist;
}

String _getBackgroundPath(String node) {
  final nodeRegExp = RegExp(r'\(([^)]*)\)');
  final nodeBackground = nodeRegExp.firstMatch(node).group(1);

  return 'assets/skyboxes/$nodeBackground.webp';
}

ImageProvider skybox(BuildContext context, String node) {
  const derelict = AssetImage('assets/skyboxes/Derelict.webp');
  bool isError = false;

  _checkBackground(context, node).then((data) => isError = data);

  return isError ? derelict : AssetImage(_getBackgroundPath(node));
}

bool compareIds(
    List<WorldstateObject> previous, List<WorldstateObject> current) {
  const _deep = DeepCollectionEquality();

  final previousIds = previous.map<String>((w) => w.id);
  final currentIds = current.map<String>((w) => w.id);

  return !_deep.equals(previousIds ?? [], currentIds ?? []);
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
