import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'cards/acolytes.dart';
import 'cards/alerts.dart';
import 'cards/cycle.dart';
import 'cards/events.dart';
import 'cards/invasionsCard.dart';
import 'cards/sortie.dart';
import 'cards/trader.dart';
import 'cards/vallis.dart';

class Feed extends StatefulWidget {
  const Feed({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<Feed> {
  void _addEvents(List<Events> events, List<Widget> childeren) =>
      events.isNotEmpty
          ? childeren.insert(0, Event(event: events.first))
          : null;

  void _addAcolytes(List<PersistentEnemies> enemies, List<Widget> childeren) =>
      enemies.isNotEmpty ? childeren.insert(1, Acolytes()) : null;

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: () => state.update(),
      child: StreamBuilder<WorldState>(
          stream: state.worldstate,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());

            final List<Widget> childeren = [
              const CetusCycle(cycle: Cycle.cetus),
              OrbVallis(),
              const CetusCycle(cycle: Cycle.earth),
              AlertTile(),
              const InvasionCard(),
              Trader(),
              SculptureMissions()
            ];

            _addEvents(snapshot.data.events, childeren);
            _addAcolytes(snapshot.data.persistentEnemies, childeren);

            return ListView(children: childeren);
          }),
    );
  }
}
