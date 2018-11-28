import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/resources/factions.dart';

import '../widgets/cards.dart';
import '../widgets/timer.dart';
import 'syndicate_missions.dart';
import 'map.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final syndicate = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder(
        stream: syndicate.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return RefreshIndicator(
            onRefresh: () => syndicate.update(),
            child: ListView(children: <Widget>[
              SizedBox(
                height: 50.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Bounties expire in',
                            style: TextStyle(
                                fontSize: 20.0,
                                color:
                                    Theme.of(context).textTheme.body1.color)),
                        Timer(
                            duration: syndicate.bountyTime,
                            size: 17.0,
                            callback: syndicate.update())
                      ]),
                ),
              ),
              snapshot.data.syndicates.isEmpty
                  ? Center(child: Text('Retrieving new bounties...'))
                  : Column(
                      children: snapshot.data.syndicates
                          .map((s) =>
                              _buildSyndicate(context, s, snapshot.data.events))
                          .toList())
            ]),
          );
        });
  }
}

Widget _buildSyndicate(
    BuildContext context, Syndicates syndicate, List<Events> events) {
  final style = TextStyle(color: Colors.white);
  final ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  final solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  bool ostron = syndicate.syndicate == 'Ostrons';

  return Tiles(
    color: ostron ? ostronsColor : solarisColor,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Factions.factionIcon(syndicate.syndicate, size: 60),
      title: Text(syndicate.syndicate, style: style),
      subtitle: Text('Tap to see bounties'),
      trailing: IconButton(
          icon: Icon(Icons.map),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  Maps(location: _checkFaction(syndicate.syndicate))))),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SyndicateJobs(
                syndicate: syndicate,
                events: events,
                color: syndicate.syndicate == 'Ostrons'
                    ? ostronsColor
                    : solarisColor,
              ))),
    ),
  );
}

_checkFaction(String syndicateName) {
  switch (syndicateName) {
    case 'Ostrons':
      return Location.plains;
    default:
      return Location.vallis;
  }
}
