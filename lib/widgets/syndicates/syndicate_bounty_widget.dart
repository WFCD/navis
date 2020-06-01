import 'package:flutter/material.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/icons.dart';
import 'package:worldstate_api_model/entities.dart';

class SyndicateBounty extends StatelessWidget {
  const SyndicateBounty({
    Key key,
    @required this.job,
    @required this.faction,
  }) : super(key: key);

  final Job job;
  final SyndicateFactions faction;

  Widget _buildStanding() {
    return Container(
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Icon(AppIcons.standing, color: Colors.white),
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
      color: syndicateBackgroundColor(faction),
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
