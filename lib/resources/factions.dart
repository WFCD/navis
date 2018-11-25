import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Factions {
  static SvgPicture factionIcon(String faction,
      {double size, bool hasColor = true}) {
    final color = hasColor ? factionColor(faction) : Colors.white;

    switch (faction) {
      case 'Grineer':
        return SvgPicture.asset('assets/factions/Grineer.svg',
            height: size, width: size, color: color);
      case 'Corpus':
        return SvgPicture.asset('assets/factions/Corpus.svg',
            height: size, width: size, color: color);
      case 'Corrupted':
        return SvgPicture.asset('assets/factions/Corrputed.svg',
            height: size, width: size, color: color);
      default:
        return SvgPicture.asset('assets/factions/Infested.svg',
            height: size, width: size, color: color);
    }
  }

  static factionColor(String faction) {
    switch (faction) {
      case 'Corpus':
        return Colors.blue;
      case 'Grineer':
        return Colors.red[700];
      case 'Corrupted':
        return Colors.yellow[300];
      default:
        return Colors.green;
    }
  }
}
