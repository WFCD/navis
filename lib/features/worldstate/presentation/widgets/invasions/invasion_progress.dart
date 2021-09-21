import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../../constants/default_durations.dart';

import '../../../utils/faction_utils.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    Key? key,
    required this.progress,
    required this.attackingFaction,
    required this.defendingFaction,
  }) : super(key: key);

  final String attackingFaction, defendingFaction;
  final double progress;

  @override
  Widget build(BuildContext context) {
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
              colors: <Color>[
                factionColor(attackingFaction),
                factionColor(defendingFaction)
              ],
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
