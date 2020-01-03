import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/home/home.dart';

class Home extends StatelessWidget {
  const Home({Key key = const PageStorageKey<String>('feed')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<WorldstateBloc>(context).update(),
      child: BlocBuilder<WorldstateBloc, WorldStates>(
          builder: (BuildContext context, WorldStates state) {
        if (state is WorldstateLoaded) {
          final worldstate = state.worldstate;

          return ListView(
            cacheExtent: 3,
            children: <Widget>[
              const NewsBuilder(),
              if (worldstate.eventsActive) const EventBuilder(),
              if (worldstate.acolytesActive) const Acolytes(),
              if (worldstate.arbitrationActive) const ArbitrationBuilder(),
              if (worldstate.alertsActive) const AlertTile(),
              const Cycles(),
              const Trader(),
              if (worldstate.dealsActive) const Deals(),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
