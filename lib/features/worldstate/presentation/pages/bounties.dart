import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../utils/faction_utils.dart';
import '../widgets/syndicates/syndicate_bounties.dart';

class BountiesPage extends StatelessWidget {
  const BountiesPage({Key key}) : super(key: key);

  static const String route = '/bounties';

  @override
  Widget build(BuildContext context) {
    final syndicate = ModalRoute.of(context).settings.arguments as Syndicate;
    final backgroundColor = syndicateStringToEnum(syndicate.id).backgroundColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(syndicate.name.replaceFirst('Syndicate', '')),
        titleSpacing: 0.0,
        backgroundColor: backgroundColor,
      ),
      body: SyndicateBounties(syndicate: syndicate),
    );
  }
}
