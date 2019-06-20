import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum OpenWorldFactions { cetus, fortuna }

const grineer = 'assets/factions/Grineer/Grineer.svg';
const corpus = 'assets/factions/Corpus/Corpus.svg';
const corrupted = 'assets/factions/Corrupted/Corrupted.svg';
const infested = 'assets/factions/Infestation/Infested.svg';
const ostrons = 'assets/sigils/OstronSigil.svg';
const solaris = 'assets/sigils/SolarisUnited.svg';

class FactionIcon extends StatelessWidget {
  const FactionIcon(this.faction, {Key key, this.size, this.hasColor = true})
      : super(key: key);

  final String faction;
  final double size;
  final bool hasColor;

  @override
  Widget build(BuildContext context) {
    String assetName;

    switch (faction) {
      case 'Grineer':
        assetName = grineer;
        break;
      case 'Corpus':
        assetName = corpus;
        break;
      case 'Corrupted':
        assetName = corrupted;
        break;
      case 'Ostrons':
        assetName = ostrons;
        break;
      case 'Solaris United':
        assetName = solaris;
        break;
      default:
        assetName = infested;
    }

    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(assetName,
          color: hasColor ? factionColor(faction) : Colors.white),
    );
  }
}

class GetTierIcon extends StatelessWidget {
  const GetTierIcon(this.tier, [this.color = Colors.white]);

  final String tier;

  static const double _size = 30.0;
  final Color color;

  @override
  Widget build(BuildContext context) {
    SvgPicture icon;
    switch (tier) {
      case 'Lith':
        icon = SvgPicture.asset('assets/relics/Lith.svg', color: color);
        break;
      case 'Meso':
        icon = SvgPicture.asset('assets/relics/Meso.svg', color: color);
        break;
      case 'Neo':
        icon = SvgPicture.asset('assets/relics/Neo.svg', color: color);
        break;
      default:
        icon = SvgPicture.asset('assets/relics/Axi.svg', color: color);
    }

    return SizedBox(height: _size, width: _size, child: icon);
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
    case 'Ostrons':
      return const Color.fromRGBO(232, 221, 175, 1.0);
    case 'Solaris United':
      return const Color.fromRGBO(152, 92, 67, 1.0);
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
