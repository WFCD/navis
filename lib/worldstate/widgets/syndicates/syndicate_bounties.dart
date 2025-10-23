import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class SyndicateBounties extends StatelessWidget {
  const SyndicateBounties({super.key, required this.syndicate});

  final SyndicateMission syndicate;

  @override
  Widget build(BuildContext context) {
    final jobs = syndicate.bounties!..retainWhere((e) => e.type != null);

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];

        return AppCard(child: SyndicateBountyTile(job: job));
      },
    );
  }
}
