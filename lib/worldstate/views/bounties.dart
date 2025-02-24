import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({required this.syndicate, super.key});

  final SyndicateMission syndicate;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = syndicateStringToEnum(syndicate.id).secondryColor;

    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(syndicate.syndicate.replaceFirst('Syndicate', '')),
          titleSpacing: 0,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          backgroundColor: backgroundColor,
        ),
        body: SyndicateBounties(syndicate: syndicate),
      ),
    );
  }
}
