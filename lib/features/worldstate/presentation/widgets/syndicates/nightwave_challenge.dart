import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/icons.dart';
import '../../../../../core/widgets/widgets.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({Key key, this.challenge}) : super(key: key);

  final Challenge challenge;

  Widget _standingBadge() {
    final rep = '${challenge.reputation}';

    return StaticBox(
      tooltip: rep,
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NavisSystemIconWidgets.standingIcon,
          Text(rep, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.caption.color;
    final title = Theme.of(context).textTheme.subtitle1;
    final desscription = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 14, color: color);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(challenge.title, style: title),
              const SizedBox(height: 4.0),
              Text(challenge.desc, style: desscription),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (challenge?.isElite)
                      StaticBox.text(
                        color: Colors.red,
                        text: context.locale.eliteBadgeTitle,
                        fontSize: 14,
                      ),
                    _standingBadge(),
                    CountdownTimer(expiry: challenge.expiry)
                  ]),
            ]),
      ),
    );
  }
}
