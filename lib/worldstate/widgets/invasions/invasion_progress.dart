import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    super.key,
    required this.progress,
    required this.attackingFaction,
    required this.defendingFaction,
  });

  final String attackingFaction, defendingFaction;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final attacker = Factions.values.byName(attackingFaction.toLowerCase());
    final defending = Factions.values.byName(defendingFaction.toLowerCase());

    return Tooltip(
      message: '$attackingFaction vs $defendingFaction',
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: kAnimationLong,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: <Color>[attacker.primaryColor, defending.primaryColor],
              stops: <double>[progress, progress / 100],
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
            ),
          ),
        ),
      ),
    );
  }
}
