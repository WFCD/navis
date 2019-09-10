import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
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

List<Drop> jsonToRewards(String response) {
  final drops = json.decode(response).cast<Map<String, dynamic>>();

  return drops.map<Drop>((d) => Drop.fromJson(d)).toList();
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
  return previous?.isBefore(current ?? DateTime.now());
}

bool compareList(List previous, List current) {
  const _deep = DeepCollectionEquality();

  return !_deep.equals(previous ?? [], current ?? []);
}
