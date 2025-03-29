import 'dart:math';

import 'package:inventoria/inventoria.dart';
import 'package:warframestat_client/warframestat_client.dart';

extension InventoryItemDatax on InventoryItemData {
  int get rank => min(sqrt((xp ?? 0) / (itemType.isWeapon ? 500 : 1000)).floor(), maxRank);

  int get masteryPoints {
    const basePoints = 3000;
    const extra = 1000;

    final isWeapon = itemType.isWeapon;
    if (maxRank > 30) {
      const points = basePoints + extra;

      return isWeapon ? points : points * 2;
    }

    return isWeapon ? basePoints : basePoints * 2;
  }

  int get maxRank {
    const max = 30;

    final lichWeaponsRegEx = RegExp('Kuva|Tenet|Paracesis');
    if (lichWeaponsRegEx.hasMatch(name) || productCategory == 'MechSuits') {
      return max + 10;
    }

    return max;
  }

  ItemType get itemType => ItemType.byType(type);

  bool get isMissing => xp == null || xp == 0;
}

extension InventoryListX on List<InventoryItemData> {
  List<InventoryItemData> get warframes => where((i) => i.itemType == ItemType.warframes).toList();

  List<InventoryItemData> get weapons => where((i) => i.itemType.isWeapon).toList();

  List<InventoryItemData> get primaries => where((i) => i.itemType.isPrimary).toList();

  List<InventoryItemData> get secondary => where((i) => i.itemType.isSecondary).toList();

  List<InventoryItemData> get melee => where((i) => i.itemType.isMelee).toList();

  List<InventoryItemData> get companions {
    return where(
      (i) => switch (i.itemType) {
        ItemType.sentinels || ItemType.pets => true,
        _ => false,
      },
    ).toList();
  }

  List<InventoryItemData> get kDrives => where((i) => i.itemType == ItemType.kDriveComponent).toList();

  List<InventoryItemData> get archwing => where((i) => i.itemType == ItemType.archwing).toList();

  List<InventoryItemData> get archGun => where((i) => i.itemType == ItemType.archGun).toList();

  List<InventoryItemData> get archMelee => where((i) => i.itemType == ItemType.archMelee).toList();
}
