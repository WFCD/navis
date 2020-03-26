import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/home/home.dart';
import 'package:navis/widgets/home/sentient_outpost.dart';

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
            cacheExtent: 500,
            children: <Widget>[
              const NewsBuilder(),
              if (worldstate.activeEvents) const EventBuilder(),
              if (worldstate.enemyActive) const Acolytes(),
              if (worldstate.activeArbitration) const ArbitrationBuilder(),
              if (worldstate.anomalyDetected)
                SentientOutpostPanel(outpost: worldstate.sentientOutposts),
              if (worldstate.activeAlerts) const AlertTile(),
              const Cycles(),
              const Trader(),
              if (worldstate.isSaleActive) const Deals(),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
