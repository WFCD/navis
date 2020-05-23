import 'package:flutter/material.dart';
import 'package:navis/core/widgets/icons.dart';
import 'package:navis/generated/l10n.dart';
import 'package:supercharged/supercharged.dart';
import 'package:worldstate_api_model/entities.dart';

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
    debugPrint(faction.toString());
    return Container(
      height: 80.0,
      color: faction.backgroundColor,
      alignment: Alignment.centerLeft,
      child: ListTile(
        title: Text(job.type, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          NavisLocalizations.of(context)
              .levelInfo(job.enemyLevels.first, job.enemyLevels.last),
          style: const TextStyle(color: Colors.white),
        ),
        trailing: _buildStanding(),
      ),
    );
  }
}
