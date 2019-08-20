import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/layout/static_box.dart';
import 'package:navis/components/widgets/invasions_bar.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class InvasionsStyle extends StatelessWidget {
  const InvasionsStyle({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      height: 200,
      elevation: 6.0,
      provider: skybox(context, invasion.node),
      child: Column(children: <Widget>[
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        _BuildInvasionDetails(
          node: invasion.node,
          description: invasion.desc,
          eta: invasion.eta,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: InvasionBar(
            attackingFaction: invasion.attackingFaction,
            defendingFaction: invasion.defendingFaction,
            progress: invasion.completion / 100,
            lineHeight: 15.0,
          ),
        ),
      ]),
    );
  }
}

class _BuildDetails extends StatelessWidget {
  const _BuildDetails({Key key, this.faction, this.reward}) : super(key: key);

  final String faction;
  final String reward;

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

class _BuildInvasionDetails extends StatelessWidget {
  const _BuildInvasionDetails({
    Key key,
    this.node,
    this.description,
    this.eta,
  }) : super(key: key);

  final String node;
  final String description;
  final String eta;

  @override
  Widget build(BuildContext context) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final _node = Theme.of(context)
        .textTheme
        .subhead
        .copyWith(fontSize: 15, shadows: <Shadow>[shadow]);
    final _details = Theme.of(context).textTheme.caption.color;

    return Container(
      child: Column(children: <Widget>[
        Text(node, style: _node),
        Text('$description ($eta)', style: TextStyle(color: _details)),
      ]),
    );
  }
}
