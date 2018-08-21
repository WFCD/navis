import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:navis/util/assets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model.dart';
import '../widgets/cards.dart';

class QuickInvasion extends StatefulWidget {
  @override
  QuickInvasionState createState() => QuickInvasionState();
}

class QuickInvasionState extends State<QuickInvasion>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        final invasion = model.oneInvasion;

        double completion = invasion.completion.toDouble();
        String defending = invasion.defendingFaction;
        String attacking = invasion.attackingFaction;

        final chart = AnimatedCircularChart(
            size: Size(95.0, 95.0),
            percentageValues: true,
            chartType: CircularChartType.Radial,
            initialChartData: <CircularStackEntry>[
              CircularStackEntry(<CircularSegmentEntry>[
                CircularSegmentEntry(completion, _factionColor(attacking)),
                CircularSegmentEntry(100 - completion, _factionColor(defending))
              ])
            ]);

        return Tiles(
            child: Column(children: <Widget>[
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.all(4.0), child: chart),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: _factionColor(attacking),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(attacking)),
                    ),
                    Text('vs'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: _factionColor(defending),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(defending)),
                    ),
                  ]),
                ]),
          ]),
          ButtonTheme.bar(
              child: FlatButton(
                  onPressed: () => null,
                  child: Text('Tap here to see more invasions'),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))))
        ]));
      },
    );
  }

  @override
  bool get wantKeepAlive => false;
}

_factionIcon(String faction) {
  switch (faction) {
    case 'Grineer':
      return ImageAssets.grineer;
    case 'Corpus':
      return ImageAssets.corpus;
    case 'Corrupted':
      return ImageAssets.corrupted;
    default:
      return ImageAssets.infested;
  }
}

_factionColor(String faction) {
  switch (faction) {
    case 'Corpus':
      return Colors.blue[300];
    case 'Grineer':
      return Colors.red[900];
    case 'Corrupted':
      return Colors.yellow[300];
    default:
      return Colors.green;
  }
}
