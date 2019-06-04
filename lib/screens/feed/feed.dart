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
              final bool isAlertActive = state.alerts.isNotEmpty;
              final bool isInvasionsActive = state.invasions.isNotEmpty;
              final bool isFissureActive = state.fissures.isNotEmpty;
              final bool isEventActive = state.events.isNotEmpty;
              final bool areAcolytesActive = state.acolytes.isNotEmpty;
              final bool areDealsActive = state.dailyDeals.isNotEmpty;

              return CustomScrollView(slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  if (isEventActive) EventPanel(events: state.events),
                  if (areAcolytesActive) const Acolytes(),
                  const CetusCycle(),
                  const OrbVallis(),
                  const EarthCycle(),
                  if (isAlertActive) const AlertTile(),
                  if (isFissureActive) const Fissure(),
                  if (isInvasionsActive) const InvasionCard(),
                  const Trader(),
                  if (areDealsActive) const Deals(),
                  const Sorties()
                ]))
              ]);
            }
          }),
    );
  }
}
