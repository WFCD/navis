import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/layout.dart';
import 'package:navis/ui/widgets/styles.dart';

class InvasionCard extends StatelessWidget {
  const InvasionCard({Key key}) : super(key: key);

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
                  : ExpandedInfo(
                      header: Column(
                          children: invasions
                              .take(2)
                              .map((i) => _BuildInvasions(invasion: i))
                              .toList()),
                      body: Column(
                          children: invasions
                              .skip(2)
                              .map((i) => _BuildInvasions(invasion: i))
                              .toList()),
                      condition: length < 3,
                    );
            }
          }),
    );
  }
}

class _BuildInvasions extends StatelessWidget {
  const _BuildInvasions({this.invasion});

  final Invasion invasion;

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
          key: ValueKey<String>(invasion.node),
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
