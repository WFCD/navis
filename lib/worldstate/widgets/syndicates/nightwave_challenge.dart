import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({Key? key, required this.challenge})
      : super(key: key);

  final Challenge challenge;

  Widget _standingBadge() {
    final rep = '${challenge.reputation}';

    return ColoredContainer(
      tooltip: rep,
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(GenesisAssets.standing, size: 20, color: Colors.white),
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
            ListTile(
              leading: NightwaveIcon(
                isElite: challenge.isElite,
                isDaily: challenge.isDaily ?? false,
              ),
              title: Text(challenge.title, style: title),
              subtitle: Text(challenge.desc, style: desscription),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _standingBadge(),
                CountdownTimer(
                  tooltip: l10n.countdownTooltip(challenge.expiry!),
                  expiry: challenge.expiry!,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NightwaveIcon extends StatelessWidget {
  const NightwaveIcon({Key? key, this.isElite = false, this.isDaily = false})
      : super(key: key);

  final bool isElite, isDaily;

  @override
  Widget build(BuildContext context) {
    const _kIconSize = 30.0;
    late Widget icon;

    if (isElite) {
      icon = const AppIcon(
        GenesisAssets.elite,
        size: _kIconSize,
      );
    } else if (isDaily) {
      icon = const AppIcon(
        GenesisAssets.daily,
        size: _kIconSize,
      );
    } else {
      icon = const AppIcon(
        GenesisAssets.weekly,
        size: _kIconSize,
      );
    }

    return icon;
  }
}
