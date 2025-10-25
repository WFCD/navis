import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({required this.syndicate, super.key});

  final SyndicateMission syndicate;

  @override
  Widget build(BuildContext context) {
    final syn = Syndicates.syndicateStringToEnum(syndicate.name);

    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(syndicate.name.replaceFirst('Syndicate', '')),
          titleSpacing: 0,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          backgroundColor: syn.secondryColor,
        ),
        body: SyndicateBounties(syndicate: syndicate, color: syn.primaryColor),
      ),
    );
  }
}
