import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/icons.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon(
    this.faction, {
    Key key,
    this.hasColor = true,
  }) : super(key: key);

  final String faction;

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
      size: 15,
      color: hasColor ? factionColor(faction) : Colors.white,
    );
  }
}

class GetTierIcon extends StatelessWidget {
  const GetTierIcon(this.tier, [this.color = Colors.white]);

  final String tier;
  final Color color;

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (tier) {
      case 'Lith':
        icon = RelicIcons.lith;
        break;
      case 'Meso':
        icon = RelicIcons.meso;
        break;
      case 'Neo':
        icon = RelicIcons.neo;
        break;
      default:
        icon = RelicIcons.axi;
    }

    return Icon(
      icon,
      size: SizeConfig.widthMultiplier * 12,
      color: tier == 'Requiem'
          ? Colors.red
          : color, // This is temporary until there is a more distinct icon for Requiem
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
    default:
      return Colors.green;
  }
}

String expiration(DateTime expiry, {intl.DateFormat format}) {
  try {
    return format.format(expiry.toLocal());
  } catch (err) {
    return 'Fetching Date';
  }
}
