import 'package:flutter/material.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/utils/worldstate_utils.dart';
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
    final light = 'assets/factions/$faction/light.webp';
    final medium = 'assets/factions/$faction/medium.webp';
    final heavy = 'assets/factions/$faction/heavy.webp';

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

    final info = Theme.of(context).textTheme.caption.copyWith(
          fontSize: 13,
          fontStyle: FontStyle.normal,
        );

    return BackgroundImageCard(
      height: SizeConfig.heightMultiplier * 25,
      provider: skybox(context, node),
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
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
            AspectRatio(
              aspectRatio: width / height,
              child: Image.asset(
                isAssassination
                    ? 'assets/factions/$faction/$boss.webp'
                    : _getAsset(variantIndex),
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
