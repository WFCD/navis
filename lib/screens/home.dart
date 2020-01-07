import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/home/home.dart';

import '../widgets/home/home.dart';

class Home extends StatelessWidget {
  const Home({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<WorldstateBloc>(context).update,
      child: BlocBuilder<WorldstateBloc, WorldStates>(
          builder: (BuildContext context, WorldStates state) {
        if (state is WorldstateLoaded) {
          final _state = state.worldstate;

          return ListView(
            cacheExtent: 3,
            children: <Widget>[
              NewsPanel(news: _state.news),
              if (_state.eventsActive) EventsPanel(events: _state.events),
              if (_state.arbitrationActive)
                ArbitrationPanel(arbitration: _state.arbitration),
              if (_state.alertsActive) AlertPanel(alerts: _state.alerts),
              if (_state.outpostActive)
                SentientOutpostPanel(outpost: _state.sentientOutposts),
              const Cycles(),
              VoidTraderPanel(trader: _state.voidTrader),
              if (_state.dealsActive) DarvoPanel(deals: _state.dailyDeals),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
