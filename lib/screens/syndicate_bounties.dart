import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/screen_widgets/syndicates/syndicates.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateJobs extends StatelessWidget {
  const SyndicateJobs({this.faction, this.jobs});

  final SyndicateFactions faction;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(syndicateFactionsToString(faction)),
            titleSpacing: 0.0,
            backgroundColor: buildColor(faction),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              for (Job job in jobs)
                SliverStickyHeader(
                  header: SyndicateBounty(job: job, faction: faction),
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
