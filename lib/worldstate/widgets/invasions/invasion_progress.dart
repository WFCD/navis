import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    super.key,
    required this.progress,
    required this.attacker,
    required this.defending,
  });

  final Factions attacker;
  final Factions defending;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '$attacker vs $defending',
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: LinearProgressIndicator(
          minHeight: 6,
          value: progress,
          borderRadius: BorderRadius.circular(8),
          stopIndicatorColor: Colors.transparent,
          color: attacker.primaryColor,
          backgroundColor: defending.primaryColor,
        ),
      ),
    );
  }
}
