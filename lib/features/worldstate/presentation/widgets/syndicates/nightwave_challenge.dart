import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../constants/sizedbox_spacer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({Key? key, required this.challenge})
      : super(key: key);

  final Challenge challenge;

  Widget _standingBadge() {
    final rep = '${challenge.reputation}';

    return StaticBox(
      tooltip: rep,
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(NavisSysIcons.standing, size: 20, color: Colors.white),
          Text(rep, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    final title = textTheme.subtitle1;
    final desscription = textTheme.bodyText2
        ?.copyWith(fontSize: 14, color: textTheme.caption?.color);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(challenge.title, style: title),
            SizedBoxSpacer.spacerHeight4,
            Text(challenge.desc, style: desscription),
            SizedBoxSpacer.spacerHeight8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (challenge.isElite)
                  StaticBox.text(
                    color: Colors.red,
                    text: l10n.eliteBadgeTitle,
                    fontSize: 14,
                  ),
                _standingBadge(),
                CountdownTimer(expiry: challenge.expiry!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
