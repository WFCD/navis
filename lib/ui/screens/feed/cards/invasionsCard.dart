import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/expanded.dart';
import 'package:navis/ui/widgets/invasionsBar.dart';

class InvasionCard extends StatefulWidget {
  InvasionCard({Key key}) : super(key: key);

  @override
  _InvasionCard createState() => _InvasionCard();
}

class _InvasionCard extends State<InvasionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _showMore = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showMoreInvasions() async {
    _showMore = !_showMore;
    try {
      if (_showMore) {
        _controller.forward().orCancel;
      } else {
        _controller.reverse().orCancel;
      }
    } on TickerCanceled {
      // The animation was canceled, maybe it was disposed mid animation, hell if I know
      // not even sure what I'm doing anymore
    }

    setState(() => _showMore = _showMore);
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
      child: StreamBuilder(
          initialData: WorldstateBloc.initworldstate,
          stream: state.worldstate,
          builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
            final invasions = snapshot.data.invasions;
            final length = invasions.length;
            final emptyBox = Container(height: 0, width: 0);

            return invasions.isEmpty
                ? Center(child: Text('No Invasions at this time'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Container(
                            child: Column(
                                children: invasions
                                    .take(2)
                                    .map((i) => _BuildInvasions(invasion: i))
                                    .toList())),
                        ExpandedCard(
                          controller: _controller,
                          length: (108 * (length - 2)).toDouble(),
                          child: Column(
                              children: invasions
                                  .skip(2)
                                  .map((i) => _BuildInvasions(invasion: i))
                                  .toList()),
                        ),
                        length < 3
                            ? emptyBox
                            : ButtonTheme.bar(
                                child: ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                          padding: EdgeInsets.all(8.0),
                                          textColor: Colors.blue,
                                          onPressed: () {
                                            _showMoreInvasions();
                                          },
                                          child: _showMore
                                              ? Text('See less')
                                              : Text('See more'))
                                    ]),
                              )
                      ]);
          }),
    );
  }
}

class _BuildInvasions extends StatelessWidget {
  final Invasions invasion;

  _BuildInvasions({this.invasion});

  @override
  Widget build(BuildContext context) {
    final factionutils = BlocProvider.of<WorldstateBloc>(context).factionUtils;

    double completion = invasion.completion.toDouble();
    String defending = invasion.defendingFaction;
    String attacking = invasion.attackingFaction;

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(children: <Widget>[
        Text(invasion.node,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 15)),
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
                                color: factionutils.factionColor(attacking),
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
                                color: factionutils.factionColor(defending),
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
}
