import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

import 'mission_widget.dart';

class SortieMission extends StatelessWidget {
  const SortieMission({
    @required this.variants,
    @required this.faction,
    @required this.boss,
  });

  final List<Variant> variants;
  final String faction, boss;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final v in variants)
          MissionDetails(
            node: v.node,
            modifierDescription: v.modifierDescription,
            missionType: v.missionType,
            variantIndex: variants.indexOf(v),
            faction: faction,
            boss: boss,
            isAssassination:
                v.missionType.toLowerCase().contains('assassination'),
          )
      ],
    );
  }
}
