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
    final attacker = Factions.values.byName(attackingFaction.toLowerCase());
    final defending = Factions.values.byName(defendingFaction.toLowerCase());

    return Tooltip(
      message: '$attackingFaction vs $defendingFaction',
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: LinearProgressIndicator(
          minHeight: 16,
          value: progress,
          borderRadius: BorderRadius.circular(6),
          color: attacker.primaryColor,
          backgroundColor: defending.primaryColor,
        ),
      ),
    );
  }
}
