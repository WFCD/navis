import 'package:black_hole_flutter/black_hole_flutter.dart';
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
    const height = 170.0;

    final attacker = Factions.values.byName(invasion.attacker.factionKey.toLowerCase());
    final defender = Factions.values.byName(invasion.defender.factionKey.toLowerCase());

    return SkyboxCard(
      node: invasion.node,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(attacker.factionIcon, size: height * .4), Icon(defender.factionIcon, size: height * .4)],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: _InvasionDetails(node: invasion.node, description: invasion.desc, eta: invasion.eta)),
              InvasionReward(
                attacker: invasion.attacker,
                defender: invasion.defender,
                vsInfestation: invasion.vsInfestation,
              ),
              Gaps.gap4,
              InvasionProgress(
                progress: invasion.completion / decimalPoint,
                attackingFaction: invasion.attacker.factionKey,
                defendingFaction: invasion.defender.factionKey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InvasionDetails extends StatelessWidget {
  const _InvasionDetails({required this.node, required this.description, required this.eta});

  final String node;
  final String description;
  final String eta;

  @override
  Widget build(BuildContext context) {
    final nodeStyle = context.theme.textTheme.titleMedium;
    final infoStyle = context.theme.textTheme.bodySmall;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[Text(node, style: nodeStyle), Text('$description ($eta)', style: infoStyle)],
    );
  }
}
