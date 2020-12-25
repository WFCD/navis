import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/icons.dart';
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
    return Container(
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        NavisSystemIconWidgets.standingIcon,
        Text(
          job.standingStages.sum().toString(),
          style: const TextStyle(color: Colors.white),
        )
      ]),
    );
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
          context.locale.levelInfo(job.enemyLevels.first, job.enemyLevels.last),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: _buildStanding(),
      ),
    );
  }
}
