import 'dart:convert';

import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';

import 'enums.dart';

String platformToString(Platforms platform) =>
    platform.toString().split('.').last;

List<ItemObject> jsonToItemObjects(String data) {
  final searchs = json.decode(data).cast<Map<String, dynamic>>();

  return searchs.map<ItemObject>(_jsonToItemObject).toList();
}

ItemObject _jsonToItemObject(Map<String, dynamic> item) {
  if (item['category'] == 'Warframes' ||
      item['category'] == 'Archwing' && !item.containsKey('damage')) {
    return Warframe.fromJson(item);
  }

  if (item['category'] == 'Primary' ||
      item['category'] == 'Secondary' ||
      item['category'] == 'Melee') {
    return Weapon.fromJson(item);
  }

  return BasicItem.fromJson(item);
}

List<SynthTarget> jsonToTargets(String data) {
  final targets = json.decode(data) as List<dynamic>;

  return targets.map<SynthTarget>((t) => SynthTarget.fromJson(t)).toList();
}
