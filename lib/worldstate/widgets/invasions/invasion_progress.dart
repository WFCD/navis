import 'package:flutter/material.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    super.key,
    required this.progress,
    required this.attackerColor,
    required this.defenderColor,
  });

  final Color attackerColor;
  final Color defenderColor;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '$attackerColor vs $this.defending',
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: LinearProgressIndicator(
          minHeight: 6,
          value: progress,
          borderRadius: BorderRadius.circular(8),
          stopIndicatorColor: Colors.transparent,
          color: attackerColor,
          backgroundColor: defenderColor,
        ),
      ),
    );
  }
}
