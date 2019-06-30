import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/worldstate_utils.dart';

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
