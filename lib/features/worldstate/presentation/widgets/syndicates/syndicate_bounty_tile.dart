import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../../utils/faction_utils.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({
    Key? key,
    required this.job,
    required this.faction,
  }) : super(key: key);

  final Job job;
  final SyndicateFaction faction;

  Widget _buildStanding() {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const Icon(NavisSysIcons.standing, size: 20),
      Text(job.standingStages.reduce((v, e) => v + e).toString())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(job.type ?? ''),
      subtitle: Text(
        context.l10n.levelInfo(job.enemyLevels.first, job.enemyLevels.last),
      ),
      trailing: _buildStanding(),
      onExpansionChanged: (b) => context.scrollToSelectedContent(),
      children: job.rewardPool.map((e) => ListTile(title: Text(e))).toList(),
    );
  }
}
