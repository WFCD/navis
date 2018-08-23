import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../json/invasions.dart';
import '../model.dart';
import '../widgets/cards.dart';
import '../widgets/invasionsBar.dart';

class InvasionCard extends StatefulWidget {
  @override
  _InvasionCard createState() => _InvasionCard();
}

class _InvasionCard extends State<InvasionCard> {
  @override
  Widget build(BuildContext context) {
    List items = <Widget>[
      Container(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RichText(
                  text: new TextSpan(
                      text: 'Invasions', style: TextStyle(fontSize: 20.0)))
            ],
          )),
      Divider(color: Theme.of(context).accentColor),
    ];

    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        items.addAll(
            model.invasion.map((i) => _buildInvasions(context, i)).toList());
        return Tiles(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: items));
      },
    );
  }
}

Widget _buildInvasions(BuildContext context, Invasions invasion) {
  double completion = invasion.completion.toDouble();
  String defending = invasion.defendingFaction;
  String attacking = invasion.attackingFaction;

  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(children: <Widget>[
      Text(invasion.node, style: TextStyle(fontSize: 15.0)),
      Text('${invasion.desc} (${invasion.eta})',
          style: TextStyle(color: Theme.of(context).textTheme.caption.color)),
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              invasion.attackerReward.itemString.isEmpty
                  ? Container(height: 0.0, width: 0.0)
                  : Padding(
                      padding: const EdgeInsets.only(right: 4.0, top: 8.0),
                      child: Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: _factionColor(attacking),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(invasion.attackerReward.itemString)),
                    ),
              invasion.defenderReward.itemString.isEmpty
                  ? Container(height: 0.0, width: 0.0)
                  : Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                      child: Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: _factionColor(defending),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(invasion.defenderReward.itemString)),
                    )
            ]),
      ),
      InvasionBar(
        width: 389.0,
        lineHeight: 15.0,
        progress: completion / 100,
        attackingFaction: attacking,
        defendingFaction: defending,
      )
    ]),
  );
}

_factionColor(String faction) {
  switch (faction) {
    case 'Corpus':
      return Colors.blue;
    case 'Grineer':
      return Colors.red[700];
    case 'Corrupted':
      return Colors.yellow[300];
    default:
      return Colors.green;
  }
}
