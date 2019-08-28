import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/screen_widgets/syndicates/syndicates.dart';
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
                  header: SyndicateBounty(job: job, faction: widget.faction),
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
