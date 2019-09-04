import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/screen_widgets/syndicates/syndicates.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateJobs extends StatelessWidget {
  const SyndicateJobs();

  @override
  Widget build(BuildContext context) {
    final Syndicate syndicate = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(syndicate.name),
            titleSpacing: 0.0,
            backgroundColor:
                buildColor(stringToSyndicateFaction(syndicate.name)),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              for (Job job in syndicate?.jobs ?? [])
                SliverStickyHeader(
                  header: SyndicateBounty(
                    job: job,
                    faction: stringToSyndicateFaction(syndicate.name),
                  ),
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
