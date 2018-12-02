import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../cards/acolytes.dart';
import '../cards/alerts.dart';
import '../cards/cycle.dart';
import '../cards/events.dart';
import '../cards/invasionsCard.dart';
import '../cards/sortie.dart';
import '../cards/trader.dart';
import '../cards/vallis.dart';

class Feed extends StatefulWidget {
  Feed({Key key = const PageStorageKey<String>('feed')}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder(
        stream: state.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          final snap = snapshot.data;
          final emptyBox = Container(height: 0.0, width: 0.0);

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final event = snap.events.isEmpty;
          final acolytes = snap.persistentEnemies.isEmpty;
          final invasions = snap.invasions.isEmpty;
          final sortie = snap.sortie.variants.isEmpty;
          final alerts = snap.alerts.isEmpty;

          return RefreshIndicator(
              onRefresh: () => state.update(),
              child: CustomScrollView(slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    event ? emptyBox : Event(event: snap.events.first),
                    acolytes ? emptyBox : Acolytes(),
                    CetusCycle(cycle: Cycle.cetus),
                    OrbVallis(),
                    CetusCycle(cycle: Cycle.earth),
                    alerts ? emptyBox : AlertTile(),
                    invasions ? emptyBox : InvasionCard(),
                    snap.trader != null ? Trader() : emptyBox,
                    sortie ? emptyBox : SculptureMissions(),
                  ]),
                )
              ]));
        });
  }
}

/*

 */
