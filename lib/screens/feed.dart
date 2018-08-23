import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../cards/acolytes.dart';
import '../cards/alerts.dart';
import '../cards/cycle.dart';
import '../cards/events.dart';
import '../cards/invasionsCard.dart';
import '../cards/sortie.dart';
import '../cards/trader.dart';
import '../model.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        final event = model.events.isEmpty;
        final acolytes = model.enemies.isEmpty;
        final alerts = model.alerts.isEmpty;
        final emptyBox = Container(height: 0.0, width: 0.0);

        return RefreshIndicator(
            onRefresh: () => model.update(),
            child: ListView(children: <Widget>[
              event ? emptyBox : Event(),
              acolytes ? emptyBox : Acolytes(),
              CetusCycle(cycle: Cycle.cetus),
              CetusCycle(cycle: Cycle.earth),
              alerts ? emptyBox : AlertTile(),
              InvasionCard(),
              Trader(),
              Sortie(),
            ]));
      },
    );
  }
}
