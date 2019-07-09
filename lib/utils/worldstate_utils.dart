import 'dart:convert';

import 'package:codable/codable.dart';
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

  state.syndicates.retainWhere(
      (s) => s.name.contains(RegExp('(Ostrons)|(Solaris United)')) == true);

  state.syndicates.sort((a, b) => a.name.compareTo(b.name));

  state.voidFissures.removeWhere((v) =>
      v.active == false ||
      v.expiry.difference(DateTime.now().toUtc()) < const Duration(seconds: 1));

  state.voidFissures.sort((a, b) => a.tierNum.compareTo(b.tierNum));

  return state;
}

List<Drop> jsonToRewards(String response) {
  final List<dynamic> drops = json.decode(response);

  return drops.map<Drop>((d) {
    final key = KeyedArchive.unarchive(d);
    return Drop()..decode(key);
  }).toList();
}

Worldstate jsonToWorldstate(Map<String, dynamic> response) {
  final key = KeyedArchive.unarchive(response);
  final Worldstate state = Worldstate()..decode(key);

  return cleanState(state);
}

ImageProvider skybox(String node) {
  final _nodeBackground = RegExp(r'\(([^)]*)\)');
  final backgroundImage =
      'assets/skyboxes/${_nodeBackground.firstMatch(node).group(1)}.webp';

  return AssetImage(backgroundImage);
}
