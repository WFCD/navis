import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class InvasionReward extends StatelessWidget {
  const InvasionReward({
    super.key,
    required this.attacker,
    required this.defender,
    this.vsInfestation = false,
  });

  final InvasionFaction attacker;
  final InvasionFaction defender;
  final bool vsInfestation;

  @override
  Widget build(BuildContext context) {
    final a = Factions.values.byName(attacker.factionKey.toLowerCase());
    final d = Factions.values.byName(defender.factionKey.toLowerCase());

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!vsInfestation)
          _InvasionRewardBox(
            color: a.primaryColor,
            reward: attacker.reward!.itemString,
          ),
        const Spacer(),
        _InvasionRewardBox(
          color: d.primaryColor,
          reward: defender.reward!.itemString,
        ),
      ],
    );
  }
}

class _InvasionRewardBox extends StatelessWidget {
  const _InvasionRewardBox({required this.color, required this.reward});

  final Color color;
  final String reward;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 3;

    // return SizedBox(
    //   width: width,
    //   child: Material(
    //     elevation: 4,
    //     color: Colors.transparent,
    //     child: ColoredContainer.text(
    //       color: color,
    //       text: reward,
    //     ),
    //   ),
    // );

    return Tooltip(
      message: reward,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Text(
                reward,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
