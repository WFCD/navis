import 'package:flutter/material.dart';
import 'package:navis/widgets/common/fa_icon.dart';
import 'package:navis/widgets/icons.dart';

enum SyndicateFactions {
  cetusSyndicate,
  solarisSyndicate,
  simaris,
  nightwave,
  hexis
}

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
    IconData icon;

    switch (syndicate) {
      case SyndicateFactions.cetusSyndicate:
        icon = SyndicateGlyphs.ostron;
        break;
      case SyndicateFactions.solarisSyndicate:
        icon = SyndicateGlyphs.solaris;
        break;
      case SyndicateFactions.simaris:
        icon = SyndicateGlyphs.simaris;
        break;
      case SyndicateFactions.nightwave:
        icon = SyndicateGlyphs.nightwave;
        break;
      default:
        icon = SyndicateGlyphs.hexis;
        break;
    }

    return FaIcon(
      icon,
      size: 50,
      color: color ?? syndicateIconColor(syndicate),
      textDirection: TextDirection.ltr,
    );
  }
}

Color syndicateIconColor(SyndicateFactions syndicate) {
  switch (syndicate) {
    case SyndicateFactions.cetusSyndicate:
      return const Color(0xFFE8DDAF);
    case SyndicateFactions.solarisSyndicate:
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
    case SyndicateFactions.cetusSyndicate:
      return const Color(0xFFB74624);
    case SyndicateFactions.solarisSyndicate:
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
  final cleaned = faction.replaceAll(RegExp(r'[0-9]'), '');

  switch (cleaned) {
    case 'CetusSyndicate':
      return SyndicateFactions.cetusSyndicate;
    case 'SolarisSyndicate':
      return SyndicateFactions.solarisSyndicate;
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
    case SyndicateFactions.cetusSyndicate:
      return 'Ostrons';
    case SyndicateFactions.solarisSyndicate:
      return 'Solaris United';
    case SyndicateFactions.simaris:
      return 'Simaris';
    case SyndicateFactions.nightwave:
      return 'Nightwave';
    default:
      return 'Hexis';
  }
}
