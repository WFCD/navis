import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/ui/widgets/cards.dart';
import 'rewards.dart';

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
    final futils = bloc.factionUtils;

    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(futils.factionCheck(widget.faction)),
            backgroundColor: futils.buildColor(widget.faction)),
        body: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorldstateUninitialized)
                return const Center(child: CircularProgressIndicator());

              if (state is WorldstateLoaded) {
                final List<Syndicates> syndicate = state.worldState.syndicates
                    .where((syn) =>
                        syn.syndicate == futils.factionCheck(widget.faction))
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
