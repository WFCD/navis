import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:wfcd_client/entities.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({super.key, required this.nightwave});

  final Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...nightwave.daily
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c)),
        ...nightwave.weekly
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c)),
      ],
    );
  }
}
