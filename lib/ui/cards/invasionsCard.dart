import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app_model.dart';
import '../../models/invasions.dart';
import '../widgets/cards.dart';
import '../widgets/invasionsBar.dart';

class InvasionCard extends StatefulWidget {
  @override
  _InvasionCard createState() => _InvasionCard();
}

class _InvasionCard extends State<InvasionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;
  Animation<double> _iconTurn;
  bool _showMore = false;
  double height = 0.0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _iconTurn = Tween<double>(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _expand(int length) {
    _showMore = !_showMore;
    if (_showMore) {
      setState(() {
        height = (106 * (length - 2)).toDouble();
        _controller.forward();
      });
    } else {
      setState(() {
        height = 0.0;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = Container(
        padding: EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    text: 'Invasions', style: TextStyle(fontSize: 20.0)))
          ],
        ));

    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        if (model.invasion.length < 0) {
          return Tiles(
              child: Column(children: <Widget>[
            title,
            Divider(color: Theme.of(context).accentColor),
            Container(child: _buildInvasions(context, model.invasion.first))
          ]));
        }

        return Tiles(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              title,
              Divider(color: Theme.of(context).accentColor),
              InkWell(
                  onTap: () => _expand(model.invasion.length),
                  child: Container(
                      child: Column(children: <Widget>[
                    _buildInvasions(context, model.invasion[0]),
                    _buildInvasions(context, model.invasion[1]),
                    Align(
                        alignment: Alignment.topRight,
                        child: RotationTransition(
                            turns: _iconTurn, child: Icon(Icons.expand_more))),
                  ]))),
              AnimatedContainer(
                  duration: _controller.duration,
                  height: height,
                  curve: Curves.easeInOut,
                  child: FadeTransition(
                      opacity: _opacity,
                      child: Column(
                          children: model.invasion
                              .skip(2)
                              .map((i) => _buildInvasions(context, i))
                              .toList())))
            ]));
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
