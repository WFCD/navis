import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home/components/news_builder.dart';

import 'components/acolytes.dart';
import 'components/alerts.dart';
import 'components/cycles.dart';
import 'components/deals.dart';
import 'components/events_tile.dart';
import 'components/trader.dart';

class Home extends StatelessWidget {
  const Home({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: () => wstate.update(),
      child: BlocBuilder<WorldstateBloc, WorldStates>(
          bloc: wstate,
          builder: (BuildContext context, WorldStates state) {
            if (state is WorldstateLoaded) {
              final bool areThereNews =
                  state.worldstate?.news?.isNotEmpty ?? false;
              final bool isAlertActive =
                  state.worldstate?.alerts?.isNotEmpty ?? false;
              final bool isEventActive =
                  state.worldstate?.events?.isNotEmpty ?? false;
              final bool areAcolytesActive =
                  state.worldstate?.persistentEnemies?.isNotEmpty ?? false;
              final bool areDealsActive =
                  state.worldstate?.dailyDeals?.isNotEmpty ?? false;

              return ListView(children: <Widget>[
                if (areThereNews) const NewsBuilder(),
                if (isEventActive) const EventPanel(),
                if (areAcolytesActive) const Acolytes(),
                if (isAlertActive) const AlertTile(),
                Cycles.cetus(state.worldstate.cetusCycle),
                Cycles.earth(state.worldstate.earthCycle),
                Cycles.orbValis(state.worldstate.vallisCycle),
                if (state.worldstate.voidTrader != null) const Trader(),
                if (areDealsActive) const Deals(),
              ]);
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
