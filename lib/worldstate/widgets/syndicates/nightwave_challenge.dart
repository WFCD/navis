import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({super.key, required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    final title = textTheme.titleMedium;
    final desscription = textTheme.bodyMedium?.copyWith(fontSize: 14, color: textTheme.bodySmall?.color);

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: _NightwaveIcon(isElite: challenge.isElite, isDaily: challenge.isDaily),
              title: Text(challenge.title, style: title),
              subtitle: Text(challenge.desc, style: desscription),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _StandingBadge(challenge: challenge),
                CountdownTimer(tooltip: l10n.countdownTooltip(challenge.expiry!), expiry: challenge.expiry),
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
    return ColoredContainer(
      tooltip: '${challenge.reputation}',
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(WarframeIcons.standing, size: 20, color: Colors.white),
          Text(NumberFormat().format(challenge.reputation), style: const TextStyle(color: Colors.white)),
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
      icon = const AppIcon(WarframeIcons.nightwavesElite, size: kIconSize);
    } else if (isDaily) {
      icon = const AppIcon(WarframeIcons.nightwavesDaily, size: kIconSize);
    } else {
      icon = const AppIcon(WarframeIcons.nightwavesWeekly, size: kIconSize);
    }

    return icon;
  }
}
