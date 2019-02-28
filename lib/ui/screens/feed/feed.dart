import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'cards/acolytes.dart';
import 'cards/cycle.dart';
import 'cards/events.dart';
import 'cards/fissures.dart';
import 'cards/invasionsCard.dart';
import 'cards/sortie.dart';
import 'cards/trader.dart';
import 'cards/vallis.dart';

class Feed extends StatelessWidget {
  const Feed({Key key = scrollkey}) : super(key: key);

  static const scrollkey = PageStorageKey<String>('feed');

  void _addEvents(List<Event> events, List<Widget> childeren) =>
      events.isNotEmpty
          ? childeren.insert(
              0, SliverToBoxAdapter(child: EventPanel(events: events)))
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
                const RepaintBoundary(child: Fissure()),
                const RepaintBoundary(child: InvasionCard()),
                Trader(),
                SculptureMissions()
              ];

              final List sliver = <Widget>[
                SliverList(delegate: SliverChildListDelegate(children))
              ];

              _addEvents(state.worldState.events, sliver);
              _addAcolytes(state.worldState.persistentEnemies, children);

              return CustomScrollView(slivers: sliver);
            }
          }),
    );
  }
}
