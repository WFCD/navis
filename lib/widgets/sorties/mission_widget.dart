import 'package:flutter/material.dart';
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

    final sortieBoss = boss.replaceAll(' ', '_');

    final sortie = Theme.of(context).textTheme.subtitle1.copyWith(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: color,
        );

    final info = Typography.whiteMountainView.caption.copyWith(
      fontSize: 13,
      fontStyle: FontStyle.normal,
    );

    return SkyboxCard(
      height: SizeConfig.heightMultiplier * 25,
      node: node,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$missionType - $node', style: sortie),
                  const SizedBox(height: 16),
                  LimitedBox(
                    maxHeight: SizeConfig.heightMultiplier * 25,
                    maxWidth: SizeConfig.widthMultiplier * 50,
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
                      ? 'assets/enemys/$faction/$sortieBoss.webp'
                      : _getAsset(variantIndex),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
