import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/worldstate_model/invasions.dart';
import 'package:navis/models/worldstate_model/worldstate.dart';

import '../../resources/factions.dart';
import '../widgets/cards.dart';
import '../widgets/invasionsBar.dart';

class InvasionCard extends StatefulWidget {
  InvasionCard({Key key}) : super(key: key);

  @override
  _InvasionCard createState() => _InvasionCard();
}

class _InvasionCard extends State<InvasionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;
  bool _showMore = false;
  double height = 0.0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);

    _opacity = Tween(begin: 0.0, end: 1.0)
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
    final invasions = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder<WorldState>(
        initialData: invasions.lastState,
        stream: invasions.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (snapshot.data.invasions.length < 3) {
            return Tiles(
                duration: Duration(milliseconds: 200),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Column(
                      children: snapshot.data.invasions
                          .map((i) => _buildInvasions(context, i))
                          .toList()),
                ));
          }

          return Tiles(
            duration: _controller.duration,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Column(children: <Widget>[
                    _buildInvasions(context, snapshot.data.invasions[0]),
                    _buildInvasions(context, snapshot.data.invasions[1]),
                  ])),
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: height,
                      child: FadeTransition(
                          opacity: _opacity,
                          child: Column(
                              children: snapshot.data.invasions
                                  .skip(2)
                                  .map((i) => _buildInvasions(context, i))
                                  .toList()))),
                  ButtonTheme.bar(
                    child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              padding: EdgeInsets.all(8.0),
                              textColor: Colors.blue,
                              onPressed: () =>
                                  _expand(snapshot.data.invasions.length),
                              child: _showMore
                                  ? Text('See less')
                                  : Text('See more'))
                        ]),
                  )
                ]),
          );
        });
  }
}

Widget _buildInvasions(BuildContext context, Invasions invasion) {
  double completion = invasion.completion.toDouble();
  String defending = invasion.defendingFaction;
  String attacking = invasion.attackingFaction;

  return Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: Column(children: <Widget>[
      Text(invasion.node, style: TextStyle(fontSize: 15.0)),
      Text('${invasion.desc} (${invasion.eta})',
          style: TextStyle(color: Theme.of(context).textTheme.caption.color)),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
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
                              color: DynamicFaction.factionColor(attacking),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(
                            invasion.attackerReward.itemString,
                            style: Theme.of(context).textTheme.body2,
                          )),
                    ),
              invasion.defenderReward.itemString.isEmpty
                  ? Container(height: 0.0, width: 0.0)
                  : Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                      child: Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: DynamicFaction.factionColor(defending),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(invasion.defenderReward.itemString,
                              style: Theme.of(context).textTheme.body2)),
                    )
            ]),
      ),
      InvasionBar(
        width: 389.0,
        lineHeight: 15.0,
        color: Colors.white,
        progress: completion / 100,
        attackingFaction: attacking,
        defendingFaction: defending,
      )
    ]),
  );
}
