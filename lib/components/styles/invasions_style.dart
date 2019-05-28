import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';

import '../layout.dart';
import 'invasionsBar.dart';

class InvasionStyle extends StatelessWidget {
  const InvasionStyle({this.invasion});

  final Invasion invasion;

  @override
  Widget build(BuildContext context) {
    final String defending = invasion.defendingFaction;
    final String attacking = invasion.attackingFaction;
    final double completion = invasion.completion.toDouble();

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
                if (invasion.attackerReward.itemString.isNotEmpty)
                  StaticBox.text(
                    color: factionColor(attacking),
                    padding: const EdgeInsets.only(right: 4.0, top: 8.0),
                    text: invasion.attackerReward.itemString,
                  ),
                Container(),
                if (invasion.defenderReward.itemString.isNotEmpty)
                  StaticBox.text(
                    color: factionColor(defending),
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
