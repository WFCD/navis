import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/invasions.dart';
import 'package:navis/models/worldstate.dart';

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
  SequenceAnimation _expand;
  bool _showMore = false;

  //double height = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _expand = SequenceAnimationBuilder()
        .addAnimatable(
        animatable: Tween<double>(
            begin: 0,
            end: (108 * (WorldstateBloc.invasions - 2)).toDouble()),
        from: Duration(milliseconds: 0),
        to: Duration(milliseconds: 125),
        curve: Curves.easeOut,
        tag: 'expand')
        .addAnimatable(
        animatable: Tween<double>(begin: 0, end: 1),
        from: Duration(milliseconds: 125),
        to: Duration(milliseconds: 225),
        curve: Curves.easeOut,
        tag: 'fade')
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMoreInvasions() {
    _showMore = !_showMore;
    if (_showMore) {
      _controller
          .forward()
          .orCancel;
    } else {
      _controller
          .reverse()
          .orCancel;
    }

    setState(() => _showMore = _showMore);
  }

  Widget _buildAnimation(BuildContext context, WorldState state) {
    return Container(
        height: _expand['expand'].value,
        child: FadeTransition(
            opacity: _expand['fade'],
            child: Column(
                children: state.invasions
                    .skip(2)
                    .map((i) => _buildInvasions(context, i))
                    .toList())));
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
                child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                  children: snapshot.data.invasions
                      .map((i) => _buildInvasions(context, i))
                      .toList()),
            ));
          }

          return Tiles(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Column(children: <Widget>[
                    _buildInvasions(context, snapshot.data.invasions[0]),
                    _buildInvasions(context, snapshot.data.invasions[1]),
                  ])),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) =>
                          _buildAnimation(context, snapshot.data)),
                  ButtonTheme.bar(
                    child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              padding: EdgeInsets.all(8.0),
                              textColor: Colors.blue,
                              onPressed: _showMoreInvasions,
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
