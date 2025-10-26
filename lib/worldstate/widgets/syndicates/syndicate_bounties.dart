import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class SyndicateBounties extends StatelessWidget {
  const SyndicateBounties({super.key, required this.color, required this.syndicate});

  final Color color;
  final SyndicateMission syndicate;

  @override
  Widget build(BuildContext context) {
    final bounties = syndicate.bounties;

    return ListView.builder(
      itemCount: bounties.length,
      itemBuilder: (context, index) {
        final job = bounties[index];

        return AppCard(
          child: SyndicateBountyTile(job: job, color: color),
        );
      },
    );
  }
}
