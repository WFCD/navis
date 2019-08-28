import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

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

List<Map<String, dynamic>> jsonToRewards(String response) {
  return json.decode(response).cast<Map<String, dynamic>>();
}

bool _checkBackground(BuildContext context, String node) {
  bool doesBackgroundExist = true;

  precacheImage(AssetImage(getBackgroundPath(node)), context,
      onError: (e, stack) => doesBackgroundExist = false);

  return doesBackgroundExist;
}

String getBackgroundPath(String node) {
  final _nodeBackground = RegExp(r'\(([^)]*)\)');

  return 'assets/skyboxes/${_nodeBackground.firstMatch(node).group(1)}.webp';
}

ImageProvider skybox(BuildContext context, String node) {
  if (_checkBackground(context, node))
    return AssetImage(getBackgroundPath(node));

  return const AssetImage('assets/skyboxes/Derelict.webp');
}

bool compareExpiry({DateTime previous, DateTime current}) {
  final forceFalse = DateTime.now().subtract(
      Duration(milliseconds: previous?.millisecond ?? (24 * pow(3.6, 6))));

  return previous?.isBefore(current ?? forceFalse);
}

bool compareList({List previous, List current}) {
  const _deep = DeepCollectionEquality();

  return !_deep.equals(previous ?? [], current ?? []);
}
