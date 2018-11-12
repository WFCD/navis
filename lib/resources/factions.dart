import 'package:flutter/material.dart';

import 'assets.dart';

class DynamicFaction {
  sortieColor(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 12))
      return Colors.green;
    else if (timeLeft < Duration(hours: 12) && timeLeft > Duration(hours: 6))
      return Colors.orange[700];
    else if (timeLeft <= Duration(hours: 6)) return Colors.red;
  }

  static factionIcon(String faction, {double size}) {
    switch (faction) {
      case 'Grineer':
        return Icon(ImageAssets.grineer,
            size: size, color: factionColor(faction));
      case 'Corpus':
        return Icon(ImageAssets.corpus,
            size: size, color: factionColor(faction));
      case 'Corrupted':
        return Icon(ImageAssets.corrupted,
            size: size, color: factionColor(faction));
      default:
        return Icon(ImageAssets.infested,
            size: size, color: factionColor(faction));
    }
  }

  static factionColor(String faction) {
    switch (faction) {
      case 'Corpus':
        return Colors.blue[300];
      case 'Grineer':
        return Colors.red[900];
      case 'Corrupted':
        return Colors.yellow[300];
      default:
        return Colors.green;
    }
  }
}
