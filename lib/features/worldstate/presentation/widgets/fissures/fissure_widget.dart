import 'package:flutter/material.dart';
import 'package:navis/core/widgets/skybox_card.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

import 'relic_icons.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({Key key, this.fissure}) : super(key: key);

  final VoidFissure fissure;

  static const height = 140.0;

  IconData _getIcon() {
    switch (fissure.tier) {
      case 'Lith':
        return RelicIcons.lith;
      case 'Meso':
        return RelicIcons.meso;
      case 'Neo':
        return RelicIcons.neo;
      case 'Axi':
        return RelicIcons.axi;
      default:
        return RelicIcons.requiem;
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 3.0);

    const _nodeStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 18,
      color: color,
      shadows: <Shadow>[shadow],
    );

    const _missionTypeStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 14,
      color: color,
      shadows: <Shadow>[shadow],
    );

    return SkyboxCard(
      node: fissure.node,
      height: height,
      child: ListTile(
        leading: Icon(_getIcon(), size: 50),
        title: Text(fissure.node, style: _nodeStyle),
        subtitle: Text(
          '${fissure.missionType} | ${fissure.tier}',
          style: _missionTypeStyle,
        ),
        trailing: CountdownTimer(expiry: fissure.expiry),
      ),
    );
  }
}
