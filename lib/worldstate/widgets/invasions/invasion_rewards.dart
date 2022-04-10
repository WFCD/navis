import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    Key? key,
    required this.attacker,
    required this.defender,
    this.vsInfestation = false,
  }) : super(key: key);

  final Faction attacker, defender;
  final bool vsInfestation;

  @override
  Widget build(BuildContext context) {
    final a = Factions.values.byName(attacker.factionKey.toLowerCase());
    final d = Factions.values.byName(defender.factionKey.toLowerCase());

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!vsInfestation)
          Material(
            elevation: 4,
            color: Colors.transparent,
            child: ColoredContainer.text(
              color: a.primaryColor,
              text: attacker.reward.itemString,
            ),
          ),
        const Spacer(),
        Material(
          elevation: 4,
          color: Colors.transparent,
          child: ColoredContainer.text(
            color: d.primaryColor,
            text: defender.reward.itemString,
          ),
        ),
      ],
    );
  }
}
