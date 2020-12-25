import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../common/skybox_card.dart';
import 'invasion_progress.dart';
import 'invasion_rewards.dart';

class InvasionWidget extends StatelessWidget {
  const InvasionWidget({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;
  static const height = 200.0;

  Widget _buildDetails(
      BuildContext context, String node, String description, String eta) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final nodeStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: Colors.white, fontSize: 15, shadows: <Shadow>[shadow]);

    final infoStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(color: Colors.white, shadows: <Shadow>[shadow]);

    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text(node, style: nodeStyle),
        Text('$description ($eta)', style: infoStyle),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetHeight = 20 * (MediaQuery.of(context).size.height / 100);

    return SkyboxCard(
      height: widgetHeight,
      node: invasion.node,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Spacer(),
          _buildDetails(
            context,
            invasion.node,
            invasion.desc,
            invasion.eta,
          ),
          const Spacer(),
          InvasionReward(
            attacker: invasion.attacker,
            defender: invasion.defender,
            vsInfestation: invasion.vsInfestation,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: InvasionProgress(
              progress: (invasion.completion / 100).toDouble(),
              attackingFaction: invasion.attackingFaction,
              defendingFaction: invasion.defendingFaction,
            ),
          ),
        ],
      ),
    );
  }
}
