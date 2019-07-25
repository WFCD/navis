import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/models/export.dart';

Worldstate cleanState(Worldstate state) {
  state.alerts.removeWhere((a) =>
      a.active == false ||
      a.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.news.retainWhere((art) => art.translations['en'] != null);
  state.news.sort((a, b) => b.date.compareTo(a.date));

  state.invasions.retainWhere(
      (invasion) => invasion.completion < 100 && invasion.completed == false);

  state.persistentEnemies.sort((a, b) => a.agentType.compareTo(b.agentType));

  state.syndicateMissions.retainWhere((s) =>
      s.syndicate.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

  state.syndicateMissions.sort((a, b) => a.syndicate.compareTo(b.syndicate));

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

Worldstate jsonToWorldstate(Map<String, dynamic> json) {
  final Worldstate state = Worldstate.fromJson(json);

  return cleanState(state);
}

ImageProvider skybox(String node) {
  final _nodeBackground = RegExp(r'\(([^)]*)\)');
  final backgroundImage =
      'assets/skyboxes/${_nodeBackground.firstMatch(node).group(1)}.webp';

  return AssetImage(backgroundImage);
}
