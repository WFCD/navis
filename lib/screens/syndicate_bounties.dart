import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/syndicates/syndicates.dart';
import 'package:warframestat_api_models/entities.dart';

class SyndicateJobs extends StatelessWidget {
  const SyndicateJobs();

  static const route = '/syndicate_jobs';

  @override
  Widget build(BuildContext context) {
    final Syndicate syndicate = ModalRoute.of(context).settings.arguments;
    final backgroundColor =
        syndicateBackgroundColor(syndicateStringToEnum(syndicate.id));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(syndicate.name),
          titleSpacing: 0.0,
          backgroundColor: backgroundColor,
        ),
        // ignore: prefer_const_constructors
        body: CustomScrollView(slivers: <Widget>[
          for (Job job in syndicate?.jobs ?? [])
            SliverStickyHeader(
              header: SyndicateBounty(
                job: job,
                faction: syndicateStringToEnum(syndicate.id),
              ),
            ),
        ]),
      ),
    );
  }
}
