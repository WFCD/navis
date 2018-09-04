import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:navis/util/assets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../json/events.dart';
import '../model.dart';
import '../widgets/cards.dart';

class Event extends StatefulWidget {
  @override
  _Event createState() => _Event();
}

class _Event extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        if (model.events.first.description == 'Ghoul Purge')
          return Container();
        else if (model.events.first.description == 'Relay Title')
          return Container(); //_factionEvents(
        else
          return _factionEvents(
              context, model.events.first); // context, model.events.first);
      },
    );
  }
}

Widget _factionEvents(BuildContext context, Events event) {
  double health = double.parse(event.health);
  bool checkFaction = event.faction.contains('Corpus');

  final percent = AnimatedCircularChart(
      size: Size(95.0, 95.0),
      percentageValues: true,
      edgeStyle: SegmentEdgeStyle.round,
      chartType: CircularChartType.Radial,
      initialChartData: <CircularStackEntry>[
        CircularStackEntry(<CircularSegmentEntry>[
          CircularSegmentEntry(health, checkFaction ? Colors.blue : Colors.red)
        ])
      ]);

  return Tiles(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          child: Text(event.description, style: TextStyle(fontSize: 20.0))),
      Divider(color: Theme.of(context).accentColor),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Container(
            child: Stack(alignment: Alignment.center, children: <Widget>[
          percent,
          checkFaction
              ? Icon(ImageAssets.corpus, size: 60.0)
              : Icon(ImageAssets.grineer, size: 60.0)
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(children: <Widget>[
            Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(event.victimNode)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text('${event.health}\% Remaining'),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                  '${event.rewards.first.itemString} + ${event.rewards.first.credits}cr'),
            ),
          ),
        ]),
      ])
    ]),
  ));
}
