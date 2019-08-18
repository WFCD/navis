import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/components/icons.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateJobs extends StatefulWidget {
  const SyndicateJobs({this.faction, this.jobs});

  final OpenWorldFactions faction;
  final List<Job> jobs;

  @override
  SyndicateJobsState createState() => SyndicateJobsState();
}

class SyndicateJobsState extends State<SyndicateJobs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(factionCheck(widget.faction)),
            titleSpacing: 0.0,
            backgroundColor: buildColor(widget.faction),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              for (Job job in widget.jobs)
                SliverStickyHeader(
                  header: MissionType(job: job, faction: widget.faction),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(title: Text(job.rewardPool[index]));
                      },
                      childCount: job.rewardPool.length,
                    ),
                  ),
                )
            ],
          )),
    );
  }
}

class MissionType extends StatelessWidget {
  const MissionType({
    Key key,
    @required this.job,
    @required this.faction,
  }) : super(key: key);

  final Job job;
  final OpenWorldFactions faction;

  Widget _buildStanding() {
    return Container(
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Icon(Standing.standing, color: Colors.white),
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
      color: buildColor(faction),
      alignment: Alignment.centerLeft,
      child: ListTile(
        title: Text(job.type, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          'Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: _buildStanding(),
      ),
    );
  }
}
