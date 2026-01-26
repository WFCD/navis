import 'dart:math';

import 'package:codex/codex.dart';
import 'package:warframestat_client/warframestat_client.dart';

int masteryRank(CodexItem item, int xp) {
  if (!item.masterable) throw Exception('Not a masterable item');

  return min(sqrt(xp / (item.type.isWeapon ? 500 : 1000)).floor(), item.maxLevelCap ?? 30);
}

int masteryPoints(CodexItem item) {
  if (!item.masterable) throw Exception('Not a masterable item');

  const basePoints = 3000;
  const extra = 1000;

  final isWeapon = item.type.isWeapon;
  if (item.maxLevelCap! > 30) {
    const points = basePoints + extra;
    return isWeapon ? points : points * 2;
  }

  return isWeapon ? basePoints : basePoints * 2;
}

extension InventoryListX on List<CodexItem> {
  List<CodexItem> get inProgress =>
      where(
          (i) => i.xpInfo.value != null,
        ).where((i) => masteryRank(i, i.xpInfo.value!.xp) < (i.maxLevelCap ?? 30)).toList()
        ..sort((a, b) => (b.xpInfo.value!.xp).compareTo(a.xpInfo.value!.xp));

  List<CodexItem> get warframes => where((i) => i.type == ItemType.warframes).toList();

  List<CodexItem> get weapons => where((i) => i.type.isWeapon).toList();

  List<CodexItem> get primaries => where((i) => i.type.isPrimary).toList();

  List<CodexItem> get secondary => where((i) => i.type.isSecondary).toList();

  List<CodexItem> get melee => where((i) => i.type.isMelee).toList();

  List<CodexItem> get companions {
    return where(
      (i) => switch (i.type) {
        ItemType.sentinels || ItemType.pets => true,
        _ => false,
      },
    ).toList();
  }

  List<CodexItem> get kDrives => where((i) => i.type == ItemType.kDriveComponent).toList();

  List<CodexItem> get archwing => where((i) => i.type == ItemType.archwing).toList();

  List<CodexItem> get archGun => where((i) => i.type == ItemType.archGun).toList();

  List<CodexItem> get archMelee => where((i) => i.type == ItemType.archMelee).toList();
}
