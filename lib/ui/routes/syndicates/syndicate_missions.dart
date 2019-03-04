import 'package:flutter/material.dart';
import 'package:navis/ui/widgets/icons.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SyndicateJobs extends StatefulWidget {
  const SyndicateJobs({this.faction, this.jobs});

  final OpenWorldFactions faction;
  final List<Jobs> jobs;

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
        body: ListView.builder(
            itemCount: widget.jobs.length,
            itemBuilder: (_, int index) {
              final job = widget.jobs[index];

              return StickyHeader(
                header: _buildMissionType(job, futils, widget.faction, _),
                content: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: job.rewardPool
                      .map((r) => ListTile(title: Text(r)))
                      .toList(),
                ),
              );
            }));
  }
}

Widget _buildMissionType(Jobs job, Factionutils futils,
    OpenWorldFactions faction, BuildContext context) {
  return Container(
    height: 80.0,
    color: futils.buildColor(faction),
    alignment: Alignment.centerLeft,
    child: ListTile(
        title: Text(job.type),
        subtitle:
            Text('Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}'),
        trailing: Container(
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const Icon(Standing.standing),
          Text(
              job.standingStages.cast<int>().reduce((a, b) => a + b).toString())
        ]))),
  );
}
