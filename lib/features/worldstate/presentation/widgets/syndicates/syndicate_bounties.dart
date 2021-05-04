import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:wfcd_client/entities.dart';

import '../../../utils/faction_utils.dart';
import 'syndicate_bounty_header.dart';

class SyndicateBounties extends StatelessWidget {
  const SyndicateBounties({Key? key, required this.syndicate})
      : super(key: key);

  final Syndicate syndicate;

  @override
  Widget build(BuildContext context) {
    final jobs = syndicate.jobs..retainWhere((e) => e.type != null);

    return CustomScrollView(
      slivers: <Widget>[
        for (Job job in jobs)
          SliverStickyHeader(
            header: SyndicateBountyHeader(
              job: job,
              faction: syndicateStringToEnum(syndicate.id!),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      job.rewardPool[index],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                },
                childCount: job.rewardPool.length,
              ),
            ),
          )
      ],
    );
  }
}
