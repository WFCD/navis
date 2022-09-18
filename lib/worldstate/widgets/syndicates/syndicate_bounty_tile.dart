import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({
    super.key,
    required this.job,
    required this.faction,
  });

  final Job job;
  final Syndicates faction;

  @override
  Widget build(BuildContext context) {
    // Need a unique fallback to create keys otherwise the same key can expand
    // two seprate ExpansionTiles.
    return ExpansionTile(
      key: PageStorageKey<String>('$faction${job.type ?? job.totalStanding}'),
      title: Text(job.type ?? ''),
      textColor: NavisColors.secondary,
      // Already being checked for null.
      // ignore: no-equal-arguments
      iconColor: NavisColors.secondary,
      subtitle: Text(
        context.l10n.levelInfo(job.enemyLevels.first, job.enemyLevels.last),
      ),
      trailing: _Standing(job: job),
      onExpansionChanged: (b) => context.scrollToSelectedContent(),
      children: job.rewardPool.map((e) => ListTile(title: Text(e))).toList(),
    );
  }
}

class _Standing extends StatelessWidget {
  const _Standing({required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(GenesisAssets.standing, size: 20),
        Text(job.standingStages.reduce((v, e) => v + e).toString()),
      ],
    );
  }
}
