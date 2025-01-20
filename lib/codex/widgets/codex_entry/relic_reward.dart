import 'package:flutter/material.dart';
import 'package:navis/codex/utils/mod_utils.dart';
import 'package:warframestat_client/warframestat_client.dart';

class RelicRewardWidget extends StatelessWidget {
  const RelicRewardWidget({super.key, required this.relic});

  final Relic relic;

  @override
  Widget build(BuildContext context) {
    final rewards = relic.rewards..sort((a, b) => b.chance.compareTo(a.chance));

    return Column(
      children: rewards.map(
        (r) {
          final color = r.rarity.toColor();

          return ListTile(
            textColor: color,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(r.item.name),
                Text('${r.chance}%'),
              ],
            ),
            subtitle: LinearProgressIndicator(
              color: color,
              borderRadius: BorderRadius.circular(4),
              value: r.chance / 100,
            ),
          );
        },
      ).toList(),
    );
  }
}
