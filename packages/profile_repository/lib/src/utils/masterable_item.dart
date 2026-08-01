import 'package:profile_repository/src/utils/affinity_math.dart';
import 'package:warframe_common/warframe_common.dart';

class MasterableItem {
  factory MasterableItem({required WarframeItem item, required int xp}) {
    final isWeapon = item.type.isWeapon;

    return MasterableItem._(
      item: item,
      xp: xp,
      level: calculateItemLevel(xp, maxLevel: item.maxLevel ?? 30, isWeapon: isWeapon),
      masteryPoints: calculateItemMasteryPoints(xp, maxLevel: item.maxLevel ?? 30, isWeapon: isWeapon),
    );
  }

  MasterableItem._({required this.item, required this.xp, required this.level, required this.masteryPoints});

  final WarframeItem item;
  final int xp;
  final int level;
  final int masteryPoints;
}
