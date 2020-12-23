import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../utils/faction_utils.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    Key key,
    @required this.attacker,
    @required this.defender,
    this.vsInfestation = false,
  })  : assert(attacker != null),
        assert(defender != null),
        super(key: key);

  final Faction attacker, defender;
  final bool vsInfestation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (!vsInfestation)
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: StaticBox.text(
              color: factionColor(attacker.factionKey),
              text: attacker.reward.itemString,
            ),
          ),
        const Spacer(),
        Material(
          elevation: 4,
          color: Colors.transparent,
          child: StaticBox.text(
            color: factionColor(defender.factionKey),
            text: defender.reward.itemString,
          ),
        ),
      ],
    );
  }
}
