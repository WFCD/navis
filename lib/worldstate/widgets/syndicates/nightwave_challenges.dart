import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:worldstate_models/worldstate_models.dart' as model;

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({super.key, required this.nightwave});

  final model.Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    final challenges = nightwave.challenges
      ..sort(
        (a, b) {
          if (a.isDaily && b.isDaily) return 0;
          return a.isDaily ? -1 : 1;
        },
      );

    return ListView(
      children: challenges.map((c) => NightwaveChallenge(challenge: c)).toList(),
    );
  }
}
