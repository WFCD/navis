import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/layout/static_box.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';

class InvasionsStyle extends StatelessWidget {
  const InvasionsStyle({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
        height: 200,
        provider: skybox(invasion.node),
        child: Column(children: <Widget>[
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _BuildDetails(
                    faction: invasion.attackingFaction,
                    reward: invasion.attackerReward.itemString,
                  ),
                  const Spacer(),
                  _BuildDetails(
                    faction: invasion.defendingFaction,
                    reward: invasion.defenderReward.itemString,
                  )
                ]),
          ),
          const Spacer(),
          _InvasionDetails(
            node: invasion.node,
            description: invasion.desc,
            eta: invasion.eta,
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 8.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              stops: <double>[
                (invasion.completion / 100).toDouble(),
                (invasion.completion % 100 / 100).toDouble()
              ],
              colors: <Color>[
                factionColor(invasion.attackingFaction),
                factionColor(invasion.defendingFaction)
              ],
            )),
          )
        ]));
  }
}

class _BuildDetails extends StatelessWidget {
  const _BuildDetails({Key key, this.faction, this.reward}) : super(key: key);

  final String faction, reward;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        FactionIcon(faction, size: 50, hasColor: false),
        const SizedBox(height: 8.0),
        if (reward.isNotEmpty)
          StaticBox.text(text: reward, color: factionColor(faction))
      ]),
    );
  }
}

class _InvasionDetails extends StatelessWidget {
  const _InvasionDetails({Key key, this.node, this.description, this.eta})
      : super(key: key);

  final String node, description, eta;

  @override
  Widget build(BuildContext context) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    return Container(
      child: Column(children: <Widget>[
        Text(node,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontSize: 15, shadows: <Shadow>[shadow])),
        Text('$description ($eta)',
            style: TextStyle(color: Theme.of(context).textTheme.caption.color)),
      ]),
    );
  }
}
