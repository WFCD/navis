import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:worldstate_model/worldstate_model.dart';

import 'syndicate_missions.dart';

class SyndicateStyle extends StatelessWidget {
  const SyndicateStyle({this.syndicate});

  final Syndicate syndicate;

  static const Color ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  static const Color solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  @override
  Widget build(BuildContext context) {
    final bool ostron = syndicate.name == 'Ostrons';

    return Tiles(
      color: ostron ? ostronsColor : solarisColor,
      child: InkWell(
        onTap: () => _navigateToBounties(context, syndicate),
        splashColor: Colors.transparent,
        child: Container(
          child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(child: FactionIcon(syndicate.name, size: 60.0)),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(syndicate.name,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: Colors.white)),
                  Text('Tap to see bounties',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.white70))
                ]))
          ]),
        ),
      ),
    );
  }
}

void _navigateToBounties(BuildContext context, Syndicate syn) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (_) =>
          SyndicateJobs(faction: _faction(syn.name), jobs: syn.jobs)));
}

OpenWorldFactions _faction(String faction) {
  switch (faction) {
    case 'Ostrons':
      return OpenWorldFactions.cetus;
    default:
      return OpenWorldFactions.fortuna;
  }
}
