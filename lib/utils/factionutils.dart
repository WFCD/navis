import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Factionutils {
  SvgPicture factionIcon(String faction, {double size, bool hasColor = true}) {
    final color = hasColor ? factionColor(faction) : Colors.white;

    switch (faction) {
      case 'Grineer':
        return SvgPicture.asset('assets/factions/Grineer.svg',
            height: size, width: size, color: color);
      case 'Corpus':
        return SvgPicture.asset('assets/factions/Corpus.svg',
            height: size, width: size, color: color);
      case 'Corrupted':
        return SvgPicture.asset('assets/factions/Corrupted.svg',
            height: size, width: size, color: color);
      case 'Ostrons':
        return SvgPicture.asset('assets/sigils/OstronSigil.svg',
            height: size,
            width: size,
            color: Color.fromRGBO(232, 221, 175, 1.0));
      case 'Solaris United':
        return SvgPicture.asset('assets/sigils/SolarisUnited.svg',
            height: size, width: size, color: Color.fromRGBO(152, 92, 67, 1.0));
      default:
        return SvgPicture.asset('assets/factions/Infested.svg',
            height: size, width: size, color: color);
    }
  }

  SvgPicture getTierIcon(String tier, BuildContext context) {
    final color = Theme.of(context).iconTheme.color;
    final size = 50.0;

    switch (tier) {
      case 'Lith':
        return SvgPicture.asset('assets/relics/Lith.svg',
            height: size, width: size, color: Color(0xFFcd7f32));
        break;
      case 'Meso':
        return SvgPicture.asset('assets/relics/Meso.svg',
            height: size, width: size, color: Color(0xFF201408));
        break;
      case 'Neo':
        return SvgPicture.asset('assets/relics/Neo.svg',
            height: size, width: size, color: Color(0xFFC0C0C0));
        break;
      default:
        return SvgPicture.asset('assets/relics/Axi.svg',
            height: size, width: size, color: Color(0xFFCFB53B));
    }
  }

  factionColor(String faction) {
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
