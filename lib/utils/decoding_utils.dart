import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/worldstate_utils.dart';

List<Reward> jsonToRewards(String response) {
  final List<dynamic> drops = json.decode(response);

  return drops.map<Reward>((d) {
    final key = KeyedArchive.unarchive(d);
    return Reward()..decode(key);
  }).toList();
}

WorldState jsonToWorldstate(Map<String, dynamic> response) {
  final key = KeyedArchive.unarchive(response);
  final WorldState state = WorldState()..decode(key);

  return cleanState(state);
}
