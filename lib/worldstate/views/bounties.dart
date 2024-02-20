import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({super.key, required this.syndicate});

  final SyndicateMission syndicate;

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    final backgroundColor = syndicateStringToEnum(syndicate.id).secondryColor;

    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(syndicate.syndicate.replaceFirst('Syndicate', '')),
          titleSpacing: 0,
          backgroundColor: backgroundColor,
        ),
        body: SyndicateBounties(syndicate: syndicate),
      ),
    );
  }
}
