import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class BuildMission extends StatelessWidget {
  const BuildMission(
      {@required this.variant,
      @required this.index,
      @required this.asset,
      this.faction,
      this.boss});

  final Variants variant;
  final int index;
  final String asset, faction, boss;

  Widget _buildDetails(BuildContext context) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 3.0);
    const color = Colors.white;
    const sortie = TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        color: color,
        shadows: <Shadow>[shadow]);
    const mode = TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: color,
        shadows: <Shadow>[shadow]);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 12,
        color: color,
        shadows: <Shadow>[shadow]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(child: Text('Sortie ${index + 1}', style: sortie)),
        Container(
            child:
                Text('${variant.missionType} - ${variant.node}', style: mode)),
        const SizedBox(height: 16),
        Container(child: Text(variant.modifierDescription, style: info))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAssassination = variant.missionType == 'Assassination';

    return BackgroundImageCard(
      height: 150,
      provider: skybox(context, variant.node),
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
        child: Row(children: <Widget>[
          Expanded(child: _buildDetails(context)),
          Container(
            child: Image.asset(
                isAssassination ? 'assets/factions/$faction/$boss.webp' : asset,
                height: 150,
                width: 150),
          )
        ]),
      ),
    );
  }
}
