import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'rewards.dart';

enum OpenWorldFactions { cetus, fortuna }

class SyndicateJobs extends StatefulWidget {
  final OpenWorldFactions faction;
  final List<Events> events;

  SyndicateJobs({this.faction, this.events});

  @override
  SyndicateJobsState createState() => SyndicateJobsState();
}

class SyndicateJobsState extends State<SyndicateJobs> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(_factionCheck(widget.faction)),
            backgroundColor: _buildColor(widget.faction)),
        body: StreamBuilder(
            stream: bloc.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              List<Widget> jobs = [];

              List<Syndicates> syndicate = snapshot.data.syndicates
                  .where(
                      (syn) => syn.syndicate == _factionCheck(widget.faction))
                  .toList();

              _buildEventTile(
                  widget.faction, jobs, snapshot.data.events, context);

              jobs.add(_jobs(context, syndicate));

              return ListView(children: jobs);
            }));
  }
}

Widget _jobs(BuildContext context, List<Syndicates> syndicate) {
  List<Widget> children = [
    Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Current Bounties',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    )
  ];

  Iterable<Widget> jobs =
      syndicate.first.jobs.map((j) => _buildMissionType(context, j, false));

  children.addAll(jobs);

  if (syndicate.length >= 2)
    children.add(_addUpcomingJobs(context, syndicate[1].jobs));

  return Container(
      child: Column(
    children: children,
  ));
}

Widget _addUpcomingJobs(BuildContext context, List<Jobs> upcomingJobs) {
  List<Widget> children = [
    Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Upcoming Bounties',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    )
  ];

  Iterable<Widget> jobs =
      upcomingJobs.map((job) => _buildMissionType(context, job, false));

  children.addAll(jobs);

  return Container(child: Column(children: children));
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

void _buildEventTile(OpenWorldFactions faction, List<Widget> jobs,
    List<Events> events, BuildContext context) {
  if (events.isNotEmpty &&
      events[0].jobs != null &&
      events[0].jobs.isNotEmpty &&
      _factionCheck(faction) == 'Ostrons') {
    jobs
      ..insertAll(
          0, events[0].jobs.map((j) => _buildMissionType(context, j, true)));
  }
}

Color _buildColor(OpenWorldFactions faction) {
  final ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  final solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  return _factionCheck(faction) == 'Ostrons' ? ostronsColor : solarisColor;
}

_factionCheck(OpenWorldFactions faction) {
  switch (faction) {
    case OpenWorldFactions.cetus:
      return 'Ostrons';
    case OpenWorldFactions.fortuna:
      return 'Solaris United';
  }
}
