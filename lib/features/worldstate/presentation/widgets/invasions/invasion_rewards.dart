import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';

import '../../../utils/faction_utils.dart';
import '../common/faction_logo.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    Key key,
    @required this.attackerReward,
    @required this.defenderReward,
    @required this.attackingFaction,
    @required this.defendingFaction,
  })  : assert(attackerReward != null),
        assert(defenderReward != null),
        assert(attackingFaction != null),
        assert(defendingFaction != null),
        super(key: key);

  final String attackerReward;
  final String defenderReward;

  final String attackingFaction;
  final String defendingFaction;

  @override
  Widget build(BuildContext context) {
    const iconSize = 18.0;

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
              color: factionColor(attackingFaction),
              child: Text(attackerReward),
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
              color: factionColor(defendingFaction),
              child: Text(defenderReward),
            ),
          )
      ],
    );
  }
}
