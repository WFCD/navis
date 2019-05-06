import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/acolytes.dart';
import 'components/alerts.dart';
import 'components/cycle.dart';
import 'components/deals.dart';
import 'components/events.dart';
import 'components/fissures.dart';
import 'components/invasionsCard.dart';
import 'components/sortie.dart';
import 'components/trader.dart';
import 'components/vallis.dart';

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
                const Deals(),
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
