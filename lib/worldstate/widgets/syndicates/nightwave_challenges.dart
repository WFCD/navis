import 'package:flutter/material.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenge.dart';
import 'package:wfcd_client/entities.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({Key? key, required this.nightwave})
      : super(key: key);

  final Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...nightwave.daily
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c)),
        ...nightwave.weekly
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c))
      ],
    );
  }
}
