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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (attackerReward.isNotEmpty)
              StaticBox.text(
                text: attackerReward,
                color: factionColor(attackingFaction),
              ),
            const Spacer(),
            if (defenderReward.isNotEmpty)
              StaticBox.text(
                text: defenderReward,
                color: factionColor(defendingFaction),
              )
          ]),
    );
  }
}
