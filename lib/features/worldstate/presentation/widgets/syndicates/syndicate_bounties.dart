import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../utils/faction_utils.dart';
import 'syndicate_bounty_tile.dart';

class SyndicateBounties extends StatelessWidget {
  const SyndicateBounties({Key? key, required this.syndicate})
      : super(key: key);

  final Syndicate syndicate;

  @override
  Widget build(BuildContext context) {
    final jobs = syndicate.jobs..retainWhere((e) => e.type != null);

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];

        return CustomCard(
          padding: EdgeInsets.zero,
          child: SyndicateBountyTile(
            faction: syndicateStringToEnum(syndicate.id!),
            job: job,
          ),
        );
      },
    );
  }
}
