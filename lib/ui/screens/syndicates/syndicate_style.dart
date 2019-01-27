import 'package:flutter/material.dart';

import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/routes/maps/map.dart';
import 'package:navis/ui/routes/syndicates/syndicate_missions.dart';

class Syndicate extends StatelessWidget {
  final Syndicates syndicate;

  Syndicate({this.syndicate});

  final style = TextStyle(color: Colors.white);
  final ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  final solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  @override
  Widget build(BuildContext context) {
    final factionutils = BlocProvider.of<WorldstateBloc>(context).factionUtils;
    bool ostron = syndicate.syndicate == 'Ostrons';

    return Tiles(
      color: ostron ? ostronsColor : solarisColor,
      child: InkWell(
          onTap: () => _navigateToBounties(context, syndicate),
          child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
                child: factionutils.factionIcon(syndicate.syndicate, size: 60)),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(syndicate.syndicate,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: Colors.white)),
                  Text('Tap to see bounties',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.white70))
                ])),
            IconButton(
                iconSize: 30,
                icon: Icon(Icons.map, color: Colors.white),
                onPressed: () => _navigateToMap(context, syndicate.syndicate))
          ])),
    );
  }
}

void _navigateToMap(BuildContext context, String syndicate) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Maps(location: _locaton(syndicate))));
}

void _navigateToBounties(BuildContext context, Syndicates syn) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SyndicateJobs(faction: _faction(syn.syndicate))));
}

_locaton(String syndicateName) {
  switch (syndicateName) {
    case 'Ostrons':
      return Location.plains;
    default:
      return Location.vallis;
  }
}

_faction(String faction) {
  switch (faction) {
    case 'Ostrons':
      return OpenWorldFactions.cetus;
    case 'Solaris United':
      return OpenWorldFactions.fortuna;
  }
}
