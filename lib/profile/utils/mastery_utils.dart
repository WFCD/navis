import 'dart:math';

import 'package:navis_codex/navis_codex.dart';
import 'package:warframestat_client/warframestat_client.dart';

int masteryRank(MasterableItem item) {
  return min(sqrt(item.xp / (item.item.type.isWeapon ? 500 : 1000)).floor(), item.item.maxLevel ?? 30);
}

int masteryPoints(MasterableItem item) {
  const basePoints = 3000;
  const extra = 1000;

  final isWeapon = item.item.type.isWeapon;
  if (item.item.maxLevel! > 30) {
    const points = basePoints + extra;
    return isWeapon ? points : points * 2;
  }

  return isWeapon ? basePoints : basePoints * 2;
}

extension InventoryListX on List<MasterableItem> {
  List<MasterableItem> get inProgress =>
      where((i) => i.xp != 0).where((i) => masteryRank(i) < (i.item.maxLevel ?? 30)).toList()
        ..sort((a, b) => (b.xp).compareTo(a.xp));

  List<MasterableItem> get warframes => where((i) => i.item.type == ItemType.warframes).toList();

  List<MasterableItem> get weapons => where((i) => i.item.type.isWeapon).toList();

  List<MasterableItem> get primaries => where((i) => i.item.type.isPrimary).toList();

  List<MasterableItem> get secondary => where((i) => i.item.type.isSecondary).toList();

  List<MasterableItem> get melee => where((i) => i.item.type.isMelee).toList();

  List<MasterableItem> get companions {
    return where(
      (i) => switch (i.item.type) {
        ItemType.sentinels || ItemType.pets => true,
        _ => false,
      },
    ).toList();
  }

  List<MasterableItem> get kDrives => where((i) => i.item.type == ItemType.kDriveComponent).toList();

  List<MasterableItem> get archwing => where((i) => i.item.type == ItemType.archwing).toList();

  List<MasterableItem> get archGun => where((i) => i.item.type == ItemType.archGun).toList();

  List<MasterableItem> get archMelee => where((i) => i.item.type == ItemType.archMelee).toList();
}
