import 'package:flutter/material.dart';
import 'package:navis/core/widgets/icons.dart';
import 'package:navis/features/worldstate/utils/faction_utils.dart';
import 'package:worldstate_api_model/entities.dart';

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
          job.standingStages.reduce((a, b) => a + b).toString(),
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
          'Enemy Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: _buildStanding(),
      ),
    );
  }
}
