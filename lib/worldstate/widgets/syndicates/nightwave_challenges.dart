import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenge.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({Key? key, required this.nightwave})
      : super(key: key);

  final Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15);

    return ListView(
      children: <Widget>[
        SizedBoxSpacer.spacerHeight8,
        CategoryTitle(
          title: context.l10n.dailyNightwaveTitle,
          style: style,
        ),
        ...nightwave.daily
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c)),
        SizedBoxSpacer.spacerHeight8,
        CategoryTitle(
          title: context.l10n.weeklyNightwaveTitle,
          style: style,
        ),
        ...nightwave.weekly
            .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c))
      ],
    );
  }
}
