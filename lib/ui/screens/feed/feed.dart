import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'cards/acolytes.dart';
import 'cards/alerts.dart';
import 'cards/cycle.dart';
import 'cards/events.dart';
import 'cards/invasionsCard.dart';
import 'cards/sortie.dart';
import 'cards/trader.dart';
import 'cards/vallis.dart';

class Feed extends StatelessWidget {
  const Feed({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

  void _addEvents(List<Event> events, List<Widget> childeren) =>
      events.isNotEmpty
          ? childeren.insert(0, EventPanel(events: events))
          : null;

  void _addAcolytes(List<PersistentEnemies> enemies, List<Widget> childeren) =>
      enemies.isNotEmpty ? childeren.insert(1, Acolytes()) : null;

  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: () => wstate.update(),
      child: BlocBuilder(
          bloc: wstate,
          builder: (context, state) {
            if (state is WorldstateUninitialized)
              return const Center(child: CircularProgressIndicator());

            if (state is WorldstateLoaded) {
              final List<Widget> children = [
                const CetusCycle(cycle: Cycle.cetus),
                OrbVallis(),
                const CetusCycle(cycle: Cycle.earth),
                AlertTile(),
                const InvasionCard(key: PageStorageKey<String>('invasions')),
                Trader(),
                SculptureMissions()
              ];

              _addEvents(state.worldState.events, children);
              _addAcolytes(state.worldState.persistentEnemies, children);

              return CustomScrollView(
                  key: const Key('Feed_list'),
                  slivers: <Widget>[
                    SliverList(delegate: SliverChildListDelegate(children))
                  ]);
            }
          }),
    );
  }
}
