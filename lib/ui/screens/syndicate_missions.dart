import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../widgets/cards.dart';
import 'rewards.dart';

class SyndicateJobs extends StatefulWidget {
  final Syndicates syndicate;
  final List<Events> events;
  final Color color;

  SyndicateJobs({this.syndicate, this.events, this.color});

  String get faction => syndicate.syndicate;

  @override
  SyndicateJobsState createState() => SyndicateJobsState();
}

class SyndicateJobsState extends State<SyndicateJobs> {
  @override
  Widget build(BuildContext context) {
    final syndicate = BlocProvider.of<WorldstateBloc>(context);

    List<Widget> allJobs = widget.syndicate.jobs
        .map((j) => _buildMissionType(context, j, false))
        .toList();

    if (widget.events.isNotEmpty &&
        widget.events[0].jobs != null &&
        widget.events[0].jobs.isNotEmpty &&
        widget.faction == 'Ostrons') {
      allJobs
        ..insertAll(
            0,
            widget.events[0].jobs
                .map((j) => _buildMissionType(context, j, true)));
    }

    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(widget.syndicate.syndicate),
            backgroundColor: widget.color),
        body: RefreshIndicator(
            onRefresh: () => syndicate.update(),
            child: Column(children: allJobs)));
  }
}

Widget _buildMissionType(BuildContext context, Jobs job, bool purge) {
  return Tiles(
    color: purge ? Colors.green[800] : null,
    child: ListTile(
      title: Text(job.type),
      subtitle:
          Text('Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}'),
      trailing: ButtonTheme.bar(
        child: FlatButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BountyRewards(
                      missionTYpe: job.type,
                      bountyRewards: job.rewardPool,
                    ))),
            child: Text(
              'See Rewards',
              style: TextStyle(color: purge ? Colors.white : Colors.blue),
            )),
      ),
    ),
  );
}
