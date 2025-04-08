import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({super.key, required this.job, required this.faction});

  final SyndicateJob job;
  final Syndicates faction;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: PageStorageKey<int>(job.hashCode),
      title: Text(job.type ?? ''),
      subtitle: Text(context.l10n.levelInfo(job.enemyLevels.first, job.enemyLevels.last)),
      trailing: _Standing(standingStages: job.standingStages),
      onExpansionChanged: (b) => context.scrollToSelectedContent(),
      children: job.rewardPool.map((e) => ListTile(title: Text(e))).toList(),
    );
  }
}

class _Standing extends StatelessWidget {
  const _Standing({required this.standingStages});

  final List<int> standingStages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(NumberFormat().format(standingStages.reduce((v, e) => v + e))),
        const Icon(WarframeIcons.standing, size: 20),
      ],
    );
  }
}
