import 'package:flutter/material.dart';

import '../../../utils/faction_utils.dart';
import 'faction_icons.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon({
    Key? key,
    required this.faction,
    this.iconSize = 15,
    this.hasColor = true,
  }) : super(key: key);

  final String faction;
  final double iconSize;
  final bool hasColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      () {
        switch (faction) {
          case 'Grineer':
            return FactionIcons.grineer;
          case 'Corpus':
            return FactionIcons.corpus;
          case 'Corrupted':
            return FactionIcons.corrupted;
          default:
            return FactionIcons.infested;
        }
      }(),
      size: iconSize,
      color: hasColor ? factionColor(faction) : Colors.white,
    );
  }
}
