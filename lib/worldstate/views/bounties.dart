import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class BountiesPage extends TraceableStatelessWidget {
  const BountiesPage({super.key});

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    // We have checks in other places to make sre this is never null.
    // ignore: cast_nullable_to_non_nullable
    final syndicate = ModalRoute.of(context)?.settings.arguments as Syndicate;
    final backgroundColor =
        syndicateStringToEnum(syndicate.id ?? 'navis').secondryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(syndicate.name.replaceFirst('Syndicate', '')),
        titleSpacing: 0,
        backgroundColor: backgroundColor,
      ),
      body: SyndicateBounties(syndicate: syndicate),
    );
  }
}
