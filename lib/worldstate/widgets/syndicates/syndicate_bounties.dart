import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class SyndicateBounties extends StatelessWidget {
  const SyndicateBounties({super.key, required this.syndicate});

  final Syndicate syndicate;

  @override
  Widget build(BuildContext context) {
    final jobs = syndicate.jobs..retainWhere((e) => e.type != null);

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];

        return AppCard(
          padding: EdgeInsets.zero,
          child: SyndicateBountyTile(
            faction: syndicateStringToEnum(syndicate.id ?? ''),
            job: job,
          ),
        );
      },
    );
  }
}
