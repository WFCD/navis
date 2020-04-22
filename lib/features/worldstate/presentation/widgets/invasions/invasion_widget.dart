import 'package:flutter/material.dart';
import 'package:navis/core/widgets/skybox_card.dart';
import 'package:worldstate_api_model/entities.dart';

import 'invasion_progress.dart';
import 'invasion_rewards.dart';

class InvasionWidget extends StatelessWidget {
  const InvasionWidget({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;

  static const height = 200.0;

  Widget _buildDetails(
      BuildContext context, String node, String description, String eta) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final _node = Typography.whiteMountainView.subhead
        .copyWith(fontSize: 15, shadows: <Shadow>[shadow]);

    return Container(
      child: Column(children: <Widget>[
        Text(node, style: _node),
        Text(
          '$description ($eta)',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(shadows: <Shadow>[shadow]),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SkyboxCard(
      height: height,
      node: invasion.node,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const Spacer(),
          _buildDetails(
            context,
            invasion.node,
            invasion.desc,
            invasion.eta,
          ),
          const Spacer(),
          InvasionReward(
            attackerReward: invasion.attackerReward,
            defenderReward: invasion.defenderReward,
            attackingFaction: invasion.attackingFaction,
            defendingFaction: invasion.defendingFaction,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: InvasionProgress(
              progress: (invasion.completion / 100).toDouble(),
              attackingFaction: invasion.attackingFaction,
              defendingFaction: invasion.defendingFaction,
            ),
          ),
        ]),
      ),
    );
  }
}
