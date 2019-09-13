import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/screen_widgets/home/home.dart';

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

          final bool areThereNews = worldstate?.news?.isNotEmpty ?? false;
          final bool isAlertActive = worldstate?.alerts?.isNotEmpty ?? false;
          final bool isEventActive = worldstate?.events?.isNotEmpty ?? false;
          final bool areAcolytesActive =
              worldstate?.persistentEnemies?.isNotEmpty ?? false;
          final bool areDealsActive =
              worldstate?.dailyDeals?.isNotEmpty ?? false;

          return ListView(
            cacheExtent: 3,
            children: <Widget>[
              if (areThereNews) const NewsBuilder(),
              if (isEventActive) const EventBuilder(),
              if (areAcolytesActive) const Acolytes(),
              if (isAlertActive) const AlertTile(),
              const Cycles(),
              if (state.worldstate.voidTrader != null) const Trader(),
              if (areDealsActive) const Deals(),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
