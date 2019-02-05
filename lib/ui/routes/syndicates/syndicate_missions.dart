import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'rewards.dart';

enum OpenWorldFactions { cetus, fortuna }

class SyndicateJobs extends StatefulWidget {
  const SyndicateJobs({this.faction, this.events});

  final OpenWorldFactions faction;
  final List<Events> events;

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
        body: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorldstateUninitialized)
                return const Center(child: CircularProgressIndicator());

              if (state is WorldstateLoaded) {
                final List<Syndicates> syndicate = state.worldState.syndicates
                    .where(
                        (syn) => syn.syndicate == _factionCheck(widget.faction))
                    .toList();

                return ListView(
                    children: syndicate[0]
                        .jobs
                        .map((j) => _buildMissionType(context, j))
                        .toList());
              }
            }));
  }
}

Widget _buildMissionType(BuildContext context, Jobs job) {
  return Tiles(
    child: ListTile(
      title: Text(job.type),
      subtitle:
          Text('Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}'),
      trailing: ButtonTheme.bar(
        child: FlatButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BountyRewards(
                      missionTYpe: job.type,
                      bountyRewards: job.rewardPool.cast<String>(),
                    ))),
            child: Text(
              'See Rewards',
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
      ),
    ),
  );
}

Color _buildColor(OpenWorldFactions faction) {
  const ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  const solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  return _factionCheck(faction) == 'Ostrons' ? ostronsColor : solarisColor;
}

String _factionCheck(OpenWorldFactions faction) {
  switch (faction) {
    case OpenWorldFactions.cetus:
      return 'Ostrons';
    default:
      return 'Solaris United';
  }
}
