import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:warframestat_client/warframestat_client.dart';

class RelicRewardWidget extends StatelessWidget {
  const RelicRewardWidget({super.key, required this.relic});

  final Relic relic;

  Color _toColor(num chance) {
    return switch (chance) {
      >= 20 => const Color(0xFFbd9177),
      < 20 && > 10 => const Color(0xFFd1d0d1),
      _ => const Color(0xFFece175),
    };
  }

  @override
  Widget build(BuildContext context) {
    final rewards = relic.rewards..sort((a, b) => b.chance.compareTo(a.chance));

    return Column(
      children: rewards.map((r) {
        final color = _toColor(r.chance);
        final titleStyle = context.theme.textTheme.titleSmall;

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r.item.name, style: titleStyle),
              Text('${r.chance}%', style: titleStyle?.copyWith(color: color)),
            ],
          ),
          subtitle: LinearProgressIndicator(
            color: color,
            borderRadius: BorderRadius.circular(4),
            value: r.chance / 100,
          ),
        );
      }).toList(),
    );
  }
}
