import 'package:flutter/material.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:worldstate_model/worldstate_model.dart';

import '../layout.dart';
import 'invasionsBar.dart';

class InvasionStyle extends StatelessWidget {
  const InvasionStyle({Key key, this.invasion}) : super(key: key);

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
                    text: invasion.attackerReward.itemString,
                  ),
                Container(),
                if (invasion.defenderReward.itemString.isNotEmpty)
                  StaticBox.text(
                    color: factionColor(defending),
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
