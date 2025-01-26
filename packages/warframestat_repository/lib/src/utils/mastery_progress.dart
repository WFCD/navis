import 'dart:math';

import 'package:warframestat_client/warframestat_client.dart';

class MasteryProgress {
  MasteryProgress({
    required this.item,
    required this.xp,
    required this.missing,
  });

  final MinimalItem item;
  final int xp;
  final bool missing;

  int get rank =>
      min(sqrt(xp / (item.type.isWeapon ? 500 : 1000)).floor(), maxRank);

  int get masteryPoints {
    const basePoints = 3000;
    const extra = 1000;

    final isWeapon = item.type.isWeapon;
    if (maxRank > 30) {
      const points = basePoints + extra;

      return isWeapon ? points : points * 2;
    }

    return isWeapon ? basePoints : basePoints * 2;
  }

  int get maxRank {
    const max = 30;

    final lichWeaponsRegEx = RegExp('Kuva|Tenet|Paracesis');
    if (lichWeaponsRegEx.hasMatch(item.name) ||
        item.productCategory == 'MechSuits') {
      return max + 10;
    }

    return max;
  }
}
