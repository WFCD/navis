import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

String platformToString(Platforms platform) {
  return platform.toString().split('.').last;
}

String fullPath(Platforms platform, String subject) {
  return '/${platformToString(platform)}/$subject';
}

List<BaseItem> toBaseItem(List<dynamic> data) {
  return data.map<BaseItem>((dynamic i) {
    return _toBaseItem(i as Map<String, dynamic>);
  }).toList();
}

// Only reason this is being ignored is becasue the switch statement works fine
// but it's being flagged as not returning ItemObject anyways
// ignore: missing_return
BaseItem _toBaseItem(Map<String, dynamic> item) {
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

List<SynthTarget> toSynthTargets(List<dynamic> data) {
  return data.map<SynthTarget>((dynamic t) {
    return SynthTargetModel.fromJson(t as Map<String, dynamic>);
  }).toList();
}
