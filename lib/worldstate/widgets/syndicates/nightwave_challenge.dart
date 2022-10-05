import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({super.key, required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    final title = textTheme.subtitle1;
    final desscription = textTheme.bodyText2
        ?.copyWith(fontSize: 14, color: textTheme.caption?.color);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: _NightwaveIcon(
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
                _StandingBadge(challenge: challenge),
                CountdownTimer(
                  // Will default to DateTime.now() under the hood.
                  // ignore: avoid-non-null-assertion
                  tooltip: l10n.countdownTooltip(challenge.expiry!),
                  // Will default to DateTime.now() under the hood.
                  // ignore: avoid-non-null-assertion
                  expiry: challenge.expiry!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StandingBadge extends StatelessWidget {
  const _StandingBadge({required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final rep = '${challenge.reputation}';

    return ColoredContainer(
      tooltip: rep,
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(GenesisAssets.standing, size: 20, color: Colors.white),
          Text(rep, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _NightwaveIcon extends StatelessWidget {
  const _NightwaveIcon({this.isElite = false, this.isDaily = false});

  final bool isElite;
  final bool isDaily;

  @override
  Widget build(BuildContext context) {
    const kIconSize = 30.0;
    Widget icon;

    if (isElite) {
      icon = const AppIcon(
        GenesisAssets.elite,
        size: kIconSize,
      );
    } else if (isDaily) {
      icon = const AppIcon(
        GenesisAssets.daily,
        size: kIconSize,
      );
    } else {
      icon = const AppIcon(
        GenesisAssets.weekly,
        size: kIconSize,
      );
    }

    return icon;
  }
}
