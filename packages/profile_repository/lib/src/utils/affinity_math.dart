import 'dart:math';

import 'package:warframe_common/warframe_common.dart';

// Calculations for mastery points here https://wiki.warframe.com/w/Mastery_Rank
// Calculations for affinity are here https://wiki.warframe.com/w/Affinity

int calculateItemLevel(int xp, {int maxLevel = 30, bool isWeapon = false}) {
  return min(sqrt(xp / (isWeapon ? 500 : 1000)).floor(), maxLevel);
}

int calculateItemMasteryPoints(int xp, {int maxLevel = 30, bool isWeapon = false}) {
  const basePoints = 3000;
  const overLeveling = basePoints + 1000;

  if (maxLevel > 30) return isWeapon ? overLeveling : overLeveling * 2;
  return isWeapon ? basePoints : basePoints * 2;
}

int calculateTotalIntrinsicsPoints(Intrinsics intrinsics) {
  const pointsPerRank = 1500;
  return [
    // Railjack
    intrinsics.engineering,
    intrinsics.gunnery,
    intrinsics.piloting,
    intrinsics.tactical,
    intrinsics.command,

    // Drifter
    intrinsics.riding,
    intrinsics.combat,
    intrinsics.opportunity,
    intrinsics.endurance,
  ].fold(0, (total, rank) => total + (rank * pointsPerRank));
}
