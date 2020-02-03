import 'dart:convert';

import 'package:navis/core/utils/worldstate_util.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

Worldstate toWorldstate(String data) {
  final state = json.decode(data) as Map<String, dynamic>;

  return cleanState(Worldstate.fromJson(state));
}

List<SynthTarget> toTargets(String data) {
  final targets =
      (json.decode(data) as List<dynamic>).cast<Map<String, dynamic>>();

  return targets.map<SynthTarget>((t) => SynthTarget.fromJson(t)).toList();
}

List<BaseItem> toBaseItems(String data) {
  final items =
      (json.decode(data) as List<dynamic>).cast<Map<String, dynamic>>();

  return items.map<BaseItem>(toBaseItem).toList();
}

// ignore: missing_return
BaseItem toBaseItem(Map<String, dynamic> item) {
  switch (item['category'] as String) {
    case 'Archwings':
      continue warframe;
    case 'Pets':
      continue warframe;
    case 'Sentinels':
      continue warframe;

    case 'Secondry':
      continue weapon;
    case 'Melee':
      continue weapon;
    case 'Arch-Gun':
      continue weapon;
    case 'Arch-Melee':
      continue weapon;

    warframe:
    case 'Warframes':
      return BioWeapon.fromJson(item);
    weapon:
    case 'Primary':
      return Weapon.fromJson(item);

    default:
      return BaseItem.fromJson(item);
  }
}
