import 'package:flutter/material.dart';
import 'package:navis/widgets/icons.dart';

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
      case 'Axi':
        icon = RelicIcons.axi;
        break;
      default:
        icon = RelicIcons.requiem;
    }

    return Icon(icon, size: 50);
  }
}
