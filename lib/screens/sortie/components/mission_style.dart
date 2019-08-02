import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class BuildMissions extends StatelessWidget {
  const BuildMissions({
    @required this.variants,
    @required this.faction,
    @required this.boss,
  });

  final List<Variants> variants;
  final String faction, boss;

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

  Widget _buildDetails(BuildContext context, Variants variant) {
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

    final variantIndex = variants.indexOf(variant);
    final isAssassination =
        variant.missionType.toLowerCase().contains('assassination');

    return BackgroundImageCard(
      height: 150,
      provider: skybox(context, variant.node),
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Sortie ${variantIndex + 1}',
                      style: sortie,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${variant.missionType} - ${variant.node}',
                      style: mode,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Text(
                      variant.modifierDescription,
                      style: info,
                    ),
                  )
                ],
              ),
            ),
            Container(
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        for (Variants v in variants) _buildDetails(context, v)
      ]),
    );
  }
}
