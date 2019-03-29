import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'cards/acolytes.dart';
import 'cards/alerts.dart';
import 'cards/cycle.dart';
import 'cards/deals.dart';
import 'cards/events.dart';
import 'cards/fissures.dart';
import 'cards/invasionsCard.dart';
import 'cards/sortie.dart';
import 'cards/trader.dart';
import 'cards/vallis.dart';

class Feed extends StatelessWidget {
  const Feed({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

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
              final bool isAlertFilled = state.worldState.alerts.isNotEmpty;

              final List<Widget> children = [
                const CetusCycle(cycle: Cycle.cetus),
                OrbVallis(),
                const CetusCycle(cycle: Cycle.earth),
                isAlertFilled ? AlertTile() : Container(),
                Fissure(),
                const RepaintBoundary(child: InvasionCard()),
                Trader(),
                Deals(),
                Sorties()
              ];

              final List sliver = <Widget>[
                SliverList(delegate: SliverChildListDelegate(children))
              ];

              return CustomScrollView(slivers: List.unmodifiable(() sync* {
                if (state.worldState.events.isNotEmpty)
                  yield SliverToBoxAdapter(
                      child: EventPanel(events: state.worldState.events));
                if (state.worldState.persistentEnemies.isNotEmpty)
                  yield SliverToBoxAdapter(child: Acolytes());

                yield* sliver;
              }()));
            }
          }),
    );
  }
}
