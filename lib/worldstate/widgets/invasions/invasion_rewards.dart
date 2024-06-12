import 'package:black_hole_flutter/black_hole_flutter.dart';
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
    final a = EnemyFactions.fromString(attacker.factionKey);
    final d = EnemyFactions.fromString(defender.factionKey);

    final defaultScheme = DefaultColorScheme(
      iconColor: context.theme.colorScheme.primary,
      backgroundColor: context.theme.colorScheme.secondary,
    );

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
              color: a?.colorScheme.backgroundColor ??
                  defaultScheme.backgroundColor,
              text: attacker.reward!.itemString,
            ),
          ),
        const Spacer(),
        Material(
          // It's what worked for the style.
          // ignore: no-magic-number
          elevation: 4,
          color: Colors.transparent,
          child: ColoredContainer.text(
            color:
                d?.colorScheme.backgroundColor ?? defaultScheme.backgroundColor,
            text: defender.reward!.itemString,
          ),
        ),
      ],
    );
  }
}
