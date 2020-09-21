import 'package:flutter/material.dart';
import 'package:navis/utils/faction_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward(
      {Key key, this.attacker, this.defender, this.vsInfestation})
      : super(key: key);

  final Faction attacker, defender;
  final bool vsInfestation;

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return Row(
      children: <Widget>[
        if (!vsInfestation)
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: StaticBox(
              icon: FactionIcon(
                faction: attacker.factionKey,
                iconSize: iconSize,
                hasColor: false,
              ),
              color: factionColor(attacker.factionKey),
              child: Text(attacker.reward.itemString),
            ),
          ),
        const Spacer(),
        Material(
          elevation: 4,
          color: Colors.transparent,
          child: StaticBox(
            icon: FactionIcon(
              faction: defender.factionKey,
              iconSize: iconSize,
              hasColor: false,
            ),
            iconTrailing: true,
            color: factionColor(defender.faction),
            child: Text(defender.reward.itemString),
          ),
        )
      ],
    );
  }
}
