import 'package:flutter/material.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/widgets.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    Key key,
    this.attackerReward,
    this.defenderReward,
    this.attackingFaction,
    this.defendingFaction,
  }) : super(key: key);

  final String attackerReward;
  final String defenderReward;

  final String attackingFaction;
  final String defendingFaction;

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return Row(
      children: <Widget>[
        if (attackerReward.isNotEmpty)
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: StaticBox(
              icon: FactionIcon(
                faction: attackingFaction,
                iconSize: iconSize,
                hasColor: false,
              ),
              child: Text(attackerReward),
              color: factionColor(attackingFaction),
            ),
          ),
        const Spacer(),
        if (defenderReward.isNotEmpty)
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: StaticBox(
              icon: FactionIcon(
                faction: defendingFaction,
                iconSize: iconSize,
                hasColor: false,
              ),
              iconTrailing: true,
              child: Text(defenderReward),
              color: factionColor(defendingFaction),
            ),
          )
      ],
    );
  }
}
