import 'dart:convert';

import 'package:navis/core/utils/worldstate_util.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

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

List<BaseItem> toBaseItems(List<dynamic> data) {
  return data
      .map<BaseItem>((dynamic i) => toBaseItem(i as Map<String, dynamic>))
      .toList();
}

List<SlimDrop> toDrops(List<dynamic> data) {
  return data
      .map((dynamic e) => SlimDropModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

List<RivenRoll> toRivens(String itemName, Map<String, dynamic> data) {
  final rolls = <RivenRoll>[];

  for (final key in (data[itemName] as Map<String, dynamic>).keys) {
    final roll = data[itemName][key] as Map<String, dynamic>;

    rolls.add(RivenRollModel.fromJson(roll));
  }

  return rolls;
}

List<SynthTarget> toSynthTargets(List<dynamic> data) {
  return data.map<SynthTarget>((dynamic t) {
    return SynthTargetModel.fromJson(t as Map<String, dynamic>);
  }).toList();
}

Worldstate toWorldstate(String data) {
  final state = json.decode(data) as Map<String, dynamic>;

  return cleanState(WorldstateModel.fromJson(state));
}
