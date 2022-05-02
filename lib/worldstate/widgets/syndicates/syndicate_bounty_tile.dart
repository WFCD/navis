import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({
    Key? key,
    required this.job,
    required this.faction,
  }) : super(key: key);

  final Job job;
  final Syndicates faction;

  Widget _buildStanding() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(GenesisAssets.standing, size: 20),
        Text(job.standingStages.reduce((v, e) => v + e).toString())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Need a unique fallback to create keys otherwise the same key can expand
    // two seprate ExpansionTiles.
    return ExpansionTile(
      key: PageStorageKey<String>('$faction${job.type ?? job.totalStanding}'),
      title: Text(job.type ?? ''),
      textColor: NavisColors.secondary,
      iconColor: NavisColors.secondary,
      subtitle: Text(
        context.l10n.levelInfo(job.enemyLevels.first, job.enemyLevels.last),
      ),
      trailing: _buildStanding(),
      onExpansionChanged: (b) => context.scrollToSelectedContent(),
      children: job.rewardPool.map((e) => ListTile(title: Text(e))).toList(),
    );
  }
}
