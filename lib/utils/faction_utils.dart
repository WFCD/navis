import 'package:flutter/material.dart';
import 'package:navis/widgets/icons.dart';
import 'package:navis/themes.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon({
    Key key,
    @required this.faction,
    this.iconSize = 15,
    this.hasColor = true,
  })  : assert(faction != null),
        super(key: key);

  final String faction;
  final double iconSize;
  final bool hasColor;

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (faction) {
      case 'Grineer':
        icon = FactionIcons.grineer;
        break;
      case 'Corpus':
        icon = FactionIcons.corpus;
        break;
      case 'Corrupted':
        icon = FactionIcons.corrupted;
        break;
      default:
        icon = FactionIcons.infested;
    }

    return Icon(
      icon,
      size: iconSize,
      color: hasColor ? factionColor(faction) : Colors.white,
    );
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
    case 'Infested':
      return Colors.green;
    default:
      return NavisThemes.primaryColor;
  }
}
