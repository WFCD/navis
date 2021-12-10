import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/widgets/syndicates/syndicate_bounties.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class BountiesPage extends TraceableStatelessWidget {
  const BountiesPage({Key? key}) : super(key: key);

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final syndicate = ModalRoute.of(context)?.settings.arguments! as Syndicate;
    final backgroundColor = syndicateStringToEnum(syndicate.id!).secondryColor;

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
