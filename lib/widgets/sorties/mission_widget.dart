import 'package:flutter/material.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/widgets.dart';

class MissionDetails extends StatelessWidget {
  const MissionDetails({
    Key key,
    @required this.node,
    @required this.missionType,
    @required this.modifierDescription,
    @required this.faction,
    @required this.boss,
    @required this.variantIndex,
    this.isAssassination = false,
  }) : super(key: key);

  final String node, missionType, modifierDescription, faction, boss;
  final int variantIndex;
  final bool isAssassination;

  String _getAsset(int variantIndex) {
    final light = 'assets/enemys/$faction/light.webp';
    final medium = 'assets/enemys/$faction/medium.webp';
    final heavy = 'assets/enemys/$faction/heavy.webp';

    switch (variantIndex) {
      case 0:
        return light;
      case 1:
        return medium;
      default:
        return heavy;
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    final height = SizeConfig.heightMultiplier * 15;
    final width = SizeConfig.widthMultiplier * 20;

    final sortie = Theme.of(context).textTheme.subhead.copyWith(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: color,
        );

    final info = AppTheme.theme.dark.textTheme.caption.copyWith(
      fontSize: 13,
      fontStyle: FontStyle.normal,
    );

    final boss = this.boss.replaceAll(' ', '_');

    return SkyboxCard(
      node: node,
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: SizeConfig.heightMultiplier * 25,
        child: Stack(
          children: <Widget>[
            Container(
              width: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$missionType - $node', style: sortie),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Text(modifierDescription, style: info),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AspectRatio(
                aspectRatio: width / height,
                child: Image.asset(
                  isAssassination
                      ? 'assets/enemys/$faction/$boss.webp'
                      : _getAsset(variantIndex),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
