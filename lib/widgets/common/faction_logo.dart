import 'package:flutter/material.dart';
import 'package:navis/widgets/icons.dart';

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

  Widget _buildIcon(IconData iconData) {
    return Icon(
      iconData,
      size: iconSize,
      color: hasColor ? factionColor(faction) : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (faction) {
      case 'Grineer':
        return _buildIcon(FactionIcons.grineer);
      case 'Corpus':
        return _buildIcon(FactionIcons.corpus);
      case 'Corrupted':
        return _buildIcon(FactionIcons.corrupted);
      default:
        return _buildIcon(FactionIcons.infested);
    }
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
