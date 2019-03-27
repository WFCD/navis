import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum OpenWorldFactions { cetus, fortuna }

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
          color: const Color.fromRGBO(232, 221, 175, 1.0));
    case 'Solaris United':
      return SvgPicture.asset('assets/sigils/SolarisUnited.svg',
          height: size,
          width: size,
          color: const Color.fromRGBO(152, 92, 67, 1.0));
    default:
      return SvgPicture.asset('assets/factions/Infested.svg',
          height: size, width: size, color: color);
  }
}

SvgPicture getTierIcon(String tier, BuildContext context) {
  const double size = 50.0;

  switch (tier) {
    case 'Lith':
      return SvgPicture.asset('assets/relics/Lith.svg',
          height: size, width: size, color: const Color(0xFFcd7f32));
      break;
    case 'Meso':
      return SvgPicture.asset('assets/relics/Meso.svg',
          height: size, width: size, color: const Color(0xFF201408));
      break;
    case 'Neo':
      return SvgPicture.asset('assets/relics/Neo.svg',
          height: size, width: size, color: const Color(0xFFC0C0C0));
      break;
    default:
      return SvgPicture.asset('assets/relics/Axi.svg',
          height: size, width: size, color: const Color(0xFFCFB53B));
  }
}

Color factionColor(String faction) {
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

Color buildColor(OpenWorldFactions faction) {
  const ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  const solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  return factionCheck(faction) == 'Ostrons' ? ostronsColor : solarisColor;
}

String factionCheck(OpenWorldFactions faction) {
  switch (faction) {
    case OpenWorldFactions.cetus:
      return 'Ostrons';
    default:
      return 'Solaris United';
  }
}

String expiration(DateTime expiry, {DateFormat format}) {
  try {
    return format.format(expiry.toLocal());
  } catch (err) {
    return 'Fetching Date';
  }
}
