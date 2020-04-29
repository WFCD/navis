import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:worldstate_api_model/entities.dart';

import '../../utils/syndicates_utils.dart';
import '../widgets/syndicates/syndicate_bounty_header.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({Key key}) : super(key: key);

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    final syndicate = ModalRoute.of(context).settings.arguments as Syndicate;
    final backgroundColor =
        syndicateStringToEnum(syndicate.name).syndicateBackgroundColor();

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
              header: SyndicateBountyHeader(
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
      ),
    );
  }
}
