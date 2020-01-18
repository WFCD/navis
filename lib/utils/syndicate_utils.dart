import 'package:flutter/material.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/icons.dart';

enum SyndicateFactions { ostrons, solaris, simaris, nightwave, hexis }

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({
    Key key,
    this.syndicate,
    this.color,
    this.size,
  }) : super(key: key);

  final SyndicateFactions syndicate;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _size = SizeConfig.imageSizeMultiplier * 9;

    IconData icon;

    switch (syndicate) {
      case SyndicateFactions.ostrons:
        icon = SyndicateIcons.ostronsigil;
        break;
      case SyndicateFactions.solaris:
        icon = SyndicateIcons.solarisunited;
        break;
      case SyndicateFactions.simaris:
        icon = SyndicateIcons.simaris;
        break;
      case SyndicateFactions.nightwave:
        icon = SyndicateIcons.nightwavesyndicate;
        break;
      default:
        icon = SyndicateIcons.hexis;
        break;
    }

    return Icon(
      icon,
      size: size ?? _size,
      color: color ?? syndicateIconColor(syndicate),
      textDirection: TextDirection.ltr,
    );
  }
}

Color syndicateIconColor(SyndicateFactions syndicate) {
  switch (syndicate) {
    case SyndicateFactions.ostrons:
      return const Color(0xFFE8DDAF);
    case SyndicateFactions.solaris:
      return const Color(0xFFD8C38F);
    case SyndicateFactions.nightwave:
      return const Color(0xFFFFAEAA);
    case SyndicateFactions.simaris:
      return const Color(0xFFEBD18F);
    default:
      return Colors.white;
  }
}

Color syndicateBackgroundColor(SyndicateFactions syndicate) {
  switch (syndicate) {
    case SyndicateFactions.ostrons:
      return const Color(0xFFB74624);
    case SyndicateFactions.solaris:
      return const Color(0xFF5F3C0D);
    case SyndicateFactions.nightwave:
      return const Color(0xFF6C1822);
    case SyndicateFactions.simaris:
      return const Color(0xFF5F3C0D);
    default:
      return const Color(0xFF6A5574);
  }
}

SyndicateFactions syndicateStringToEnum(String faction) {
  switch (faction) {
    case 'Ostrons':
      return SyndicateFactions.ostrons;
    case 'Solaris United':
      return SyndicateFactions.solaris;
    case 'Simaris':
      return SyndicateFactions.simaris;
    case 'Nightwave':
      return SyndicateFactions.nightwave;
    default:
      return SyndicateFactions.hexis;
  }
}

String syndicateEnumToString(SyndicateFactions faction) {
  switch (faction) {
    case SyndicateFactions.ostrons:
      return 'Ostrons';
    case SyndicateFactions.solaris:
      return 'Solaris United';
    case SyndicateFactions.simaris:
      return 'Simaris';
    case SyndicateFactions.nightwave:
      return 'Nightwave';
    default:
      return 'Hexis';
  }
}
