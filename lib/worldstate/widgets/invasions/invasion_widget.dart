import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class InvasionWidget extends StatelessWidget {
  const InvasionWidget({super.key, required this.invasion});

  final Invasion invasion;

  @override
  Widget build(BuildContext context) {
    const decimalPoint = 100;

    return SkyboxCard(
      node: invasion.node,
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Spacer(),
          _InvasionDetails(
            node: invasion.node,
            description: invasion.desc,
            eta: invasion.eta,
          ),
          const Spacer(),
          InvasionReward(
            attacker: invasion.attacker,
            defender: invasion.defender,
            vsInfestation: invasion.vsInfestation,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: InvasionProgress(
              progress: invasion.completion / decimalPoint,
              attackingFaction: invasion.attacker.factionKey,
              defendingFaction: invasion.defender.factionKey,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvasionDetails extends StatelessWidget {
  const _InvasionDetails({
    required this.node,
    required this.description,
    required this.eta,
  });

  final String node;
  final String description;
  final String eta;

  @override
  Widget build(BuildContext context) {
    const shadow = Shadow(offset: Offset(1, 0), blurRadius: 4);
    final textTheme = Theme.of(context).textTheme;

    final nodeStyle = textTheme.titleMedium?.copyWith(
      color: Colors.white,
      fontSize: 15,
      shadows: <Shadow>[shadow],
    );

    final infoStyle = textTheme.bodySmall
        ?.copyWith(color: Colors.white, shadows: <Shadow>[shadow]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(node, style: nodeStyle),
        Text('$description ($eta)', style: infoStyle),
      ],
    );
  }
}
