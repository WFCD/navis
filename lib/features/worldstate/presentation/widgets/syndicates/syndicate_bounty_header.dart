import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/icons.dart';
import '../../../../../l10n/l10n.dart';
import '../../../utils/faction_utils.dart';

class SyndicateBountyHeader extends StatelessWidget {
  const SyndicateBountyHeader({
    Key key,
    @required this.job,
    @required this.faction,
  }) : super(key: key);

  final Job job;
  final SyndicateFaction faction;

  Widget _buildStanding() {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      NavisSystemIconWidgets.standingIcon,
      Text(
        job.standingStages.sumBy((n) => n).toString(),
        style: const TextStyle(color: Colors.white),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: faction.backgroundColor,
      alignment: Alignment.centerLeft,
      child: ListTile(
        title: Text(job.type, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          context.l10n.levelInfo(job.enemyLevels.first, job.enemyLevels.last),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: _buildStanding(),
      ),
    );
  }
}
