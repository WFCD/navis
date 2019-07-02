import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/acolytes.dart';
import 'components/alerts.dart';
import 'components/cycles.dart';
import 'components/deals.dart';
import 'components/events.dart';
import 'components/trader.dart';

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
            if (state is WorldstateLoaded) {
              final bool isAlertActive = state.alerts.isNotEmpty;
              final bool isEventActive = state.events.isNotEmpty;
              final bool areAcolytesActive = state.acolytes.isNotEmpty;
              final bool areDealsActive = state.dailyDeals.isNotEmpty;

              return ListView(children: <Widget>[
                if (isEventActive) const EventPanel(),
                if (areAcolytesActive) const Acolytes(),
                ...cycles,
                if (isAlertActive) const AlertTile(),
                const Trader(),
                if (areDealsActive) const Deals(),
              ]);
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
