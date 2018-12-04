import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../widgets/cards.dart';
import 'rewards.dart';

class SyndicateJobs extends StatefulWidget {
  final Syndicates syndicate;
  final List<Events> events;

  SyndicateJobs({this.syndicate, this.events});

  String get faction => syndicate.syndicate;

  @override
  SyndicateJobsState createState() => SyndicateJobsState();
}

class SyndicateJobsState extends State<SyndicateJobs> {
  Color _buildColor() {
    final ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
    final solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

    return widget.syndicate.syndicate == 'Ostrons'
        ? ostronsColor
        : solarisColor;
  }

  void _buildEventTile(List<Widget> jobs) {
    if (widget.events.isNotEmpty &&
        widget.events[0].jobs != null &&
        widget.events[0].jobs.isNotEmpty &&
        widget.faction == 'Ostrons') {
      jobs
        ..insertAll(
            0,
            widget.events[0].jobs
                .map((j) => _buildMissionType(context, j, true)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final syndicate = BlocProvider.of<WorldstateBloc>(context);

    List<Widget> allJobs = widget.syndicate.jobs
        .map((j) => _buildMissionType(context, j, false))
        .toList();

    _buildEventTile(allJobs);

    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(widget.syndicate.syndicate),
            backgroundColor: _buildColor()),
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
