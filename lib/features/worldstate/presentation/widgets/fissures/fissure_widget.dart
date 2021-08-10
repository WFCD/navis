import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import '../common/skybox_card.dart';
import 'relic_icons.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({Key? key, required this.fissure}) : super(key: key);

  static const height = 140.0;

  final VoidFissure fissure;

  static const color = Colors.white;
  static const shadow = Shadow(offset: Offset(1, 0), blurRadius: 3);

  static const _nodeStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    color: color,
    shadows: <Shadow>[shadow],
  );

  static const _missionTypeStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    color: color,
    shadows: <Shadow>[shadow],
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SkyboxCard(
      node: fissure.node,
      height: (mediaQuery.size.height / 100) * 15,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Row(
        children: <Widget>[
          Icon(
            () {
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
            }(),
            size: (mediaQuery.size.shortestSide / 100) * 10,
          ),
          FissureInfo(
            fissure: fissure,
            nodeStyle: _nodeStyle,
            missionTypeStyle: _missionTypeStyle,
          ),
          CountdownTimer(expiry: fissure.expiry!)
        ],
      ),
    );
  }
}

class FissureInfo extends StatelessWidget {
  const FissureInfo({
    Key? key,
    required this.fissure,
    required TextStyle nodeStyle,
    required TextStyle missionTypeStyle,
  })  : _nodeStyle = nodeStyle,
        _missionTypeStyle = missionTypeStyle,
        super(key: key);

  final VoidFissure fissure;
  final TextStyle _nodeStyle;
  final TextStyle _missionTypeStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fissure.node, style: _nodeStyle),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (fissure.isStorm)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        NavisSysIcons.archwing,
                        size: 20,
                      ),
                    ),
                  Text(
                    '${fissure.missionType} | ${fissure.tier}',
                    style: _missionTypeStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
