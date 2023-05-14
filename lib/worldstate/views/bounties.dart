import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({super.key});

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    // We have checks in other places to make sre this is never null.
    final syndicate =
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)?.settings.arguments as SyndicateMission;

    final backgroundColor =
        syndicateStringToEnum(syndicate.id ?? 'navis').secondryColor;

    return TraceableWidget(
      traceTitle: 'Syndicate Bounties',
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
