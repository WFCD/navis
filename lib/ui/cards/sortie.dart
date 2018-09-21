import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app_model.dart';
import '../../models/sortie.dart';
import '../../resources/factions.dart';
import '../animation/countdown.dart';
import '../widgets/cards.dart';

class Sortie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        final factionSwitch = DynamicFaction();

        final title = ListTile(
          leading: DynamicFaction.factionIcon(model.sortie.faction, size: 45.0),
          title: Text(model.sortie.boss),
          subtitle: Text(model.sortie.faction),
          trailing: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: factionSwitch.sortieColor(
                      DateTime.parse(model.sortie.expiry)
                          .difference(DateTime.now())),
                  borderRadius: BorderRadius.circular(3.0)),
              child: StreamBuilder<Duration>(
                initialData: Duration(seconds: 60),
                stream: CounterScreenStream(DateTime.parse(model.sortie.expiry)
                    .difference(DateTime.now())),
                builder: (context, snapshot) {
                  Duration data = snapshot.data;

                  String hour = '${data.inHours}';
                  String minutes =
                      '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
                  String seconds =
                      '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return null;
                    case ConnectionState.waiting:
                      return Text('Resetting Sortie');
                    case ConnectionState.active:
                      return Text('$hour:$minutes:$seconds',
                          style: TextStyle(color: Colors.white));
                    case ConnectionState.done:
                      model.update();
                  }
                },
              )),
        );

        Widget _buildMissions(Variants variants) {
          return Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 4.0, right: 4.0, left: 4.0),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Text('${variants.missionType} - ${variants.node}',
                        style: TextStyle(fontSize: 15.0))
                  ]),
                  Row(children: <Widget>[
                    Expanded(
                        child: Text(variants.modifierDescription,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color)))
                  ]),
                ]),
              ));
        }

        List<Widget> missions = model.sortie.variants
            .map(_buildMissions)
            .toList()
              ..insert(0, title);

        return Tiles(child: Column(children: missions));
      },
    );
  }
}
