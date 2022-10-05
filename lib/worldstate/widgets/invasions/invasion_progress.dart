import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    super.key,
    required this.progress,
    required this.attackingFaction,
    required this.defendingFaction,
  });

  final String attackingFaction;
  final String defendingFaction;
  final double progress;

  @override
  Widget build(BuildContext context) {
    const decimalPoint = 100;
    final attacker = Factions.values.byName(attackingFaction.toLowerCase());
    final defending = Factions.values.byName(defendingFaction.toLowerCase());

    return Tooltip(
      message: '$attackingFaction vs $defendingFaction',
      child: Material(
        // It's what worked for the style.
        // ignore: no-magic-number
        elevation: 4,
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: kAnimationLong,
          // It's what worked for the style.
          // ignore: no-magic-number
          height: 20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(
              colors: <Color>[attacker.primaryColor, defending.primaryColor],
              stops: <double>[progress, progress / decimalPoint],
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
            ),
          ),
        ),
      ),
    );
  }
}
