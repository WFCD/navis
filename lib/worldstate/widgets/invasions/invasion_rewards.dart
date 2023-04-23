import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    super.key,
    required this.attacker,
    required this.defender,
    this.vsInfestation = false,
  });

  final InvasionFaction attacker;
  final InvasionFaction defender;
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
            // It's what worked for the style.
            // ignore: no-magic-number
            elevation: 4,
            color: Colors.transparent,
            child: ColoredContainer.text(
              color: a.primaryColor,
              text: attacker.reward.itemString,
            ),
          ),
        const Spacer(),
        Material(
          // It's what worked for the style.
          // ignore: no-magic-number
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
