import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/syndicates/syndicates.dart';
import 'package:worldstate_api_model/entities.dart';

class SyndicateJobs extends StatelessWidget {
  const SyndicateJobs();

  static const route = '/syndicate_jobs';

  @override
  Widget build(BuildContext context) {
    final Syndicate syndicate = ModalRoute.of(context).settings.arguments;
    final backgroundColor =
        syndicateBackgroundColor(syndicateStringToEnum(syndicate.name));

    return Scaffold(
        appBar: AppBar(
          title: Text(syndicate.name),
          titleSpacing: 0.0,
          backgroundColor: backgroundColor,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            for (Job job in syndicate?.jobs ?? [])
              SliverStickyHeader(
                header: SyndicateBounty(
                  job: job,
                  faction: syndicateStringToEnum(syndicate.name),
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
        ));
  }
}
