import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_client/warframestat_client.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({super.key, required this.nightwave});

  final Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...nightwave.daily.map((c) => NightwaveChallenge(challenge: c)),
        ...nightwave.weekly.map((c) => NightwaveChallenge(challenge: c)),
      ],
    );
  }
}
