import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/invasionsBar.dart';

class InvasionCard extends StatefulWidget {
  const InvasionCard({Key key}) : super(key: key);

  @override
  _InvasionCard createState() => _InvasionCard();
}

class _InvasionCard extends State<InvasionCard> {
  bool _showMore = false;

  Future<void> _showMoreInvasions() async {
    _showMore = !_showMore;

    if (mounted) setState(() => _showMore = _showMore);
  }

  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
      child: BlocBuilder(
          bloc: wstate,
          builder: (context, state) {
            if (state is WorldstateLoaded) {
              final invasions = state.worldState.invasions;
              final length = invasions.length;

              return invasions.isEmpty
                  ? const Center(child: Text('No Invasions at this time'))
                  : Column(children: <Widget>[
                      Container(
                          child: Column(
                              children: invasions
                                  .take(2)
                                  .map((i) => _BuildInvasions(invasion: i))
                                  .toList())),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState: _showMore
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: Container(),
                        secondChild: Column(
                            children: invasions
                                .skip(2)
                                .map((i) => _BuildInvasions(invasion: i))
                                .toList()),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                  padding: const EdgeInsets.all(8.0),
                                  textColor: Theme.of(context).accentColor,
                                  onPressed: length < 3
                                      ? null
                                      : () => _showMoreInvasions(),
                                  child: _showMore
                                      ? const Text('See less')
                                      : const Text('See more'))
                            ]),
                      )
                    ]);
            }
          }),
    );
  }
}

class _BuildInvasions extends StatelessWidget {
  const _BuildInvasions({this.invasion});

  final Invasions invasion;

  @override
  Widget build(BuildContext context) {
    final factionutils = BlocProvider.of<WorldstateBloc>(context).factionUtils;

    final double completion = invasion.completion.toDouble();
    final String defending = invasion.defendingFaction;
    final String attacking = invasion.attackingFaction;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(children: <Widget>[
        Text(invasion.node,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 15)),
        Text('${invasion.desc} (${invasion.eta})',
            style: TextStyle(color: Theme.of(context).textTheme.caption.color)),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                invasion.attackerReward.itemString.isEmpty
                    ? Container(height: 0.0, width: 0.0)
                    : StaticBox.text(
                        color: factionutils.factionColor(attacking),
                        padding: const EdgeInsets.only(right: 4.0, top: 8.0),
                        text: invasion.attackerReward.itemString,
                      ),
                invasion.defenderReward.itemString.isEmpty
                    ? Container(height: 0.0, width: 0.0)
                    : StaticBox.text(
                        color: factionutils.factionColor(defending),
                        padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                        text: invasion.defenderReward.itemString,
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
