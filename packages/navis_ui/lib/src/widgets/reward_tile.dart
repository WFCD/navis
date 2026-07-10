import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/src/helpers/helpers.dart';
import 'package:warframe_common/warframe_common.dart' show Rarity;

class RewardTile extends StatelessWidget {
  const RewardTile({super.key, required this.reward, required this.chance, required this.rarity});

  final String reward;
  final num chance;
  final Rarity rarity;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final color = rarity.toColor();

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(reward, style: textTheme.titleMedium),
          Text('$chance', style: textTheme.bodyMedium?.copyWith(color: color)),
        ],
      ),
      subtitle: LinearProgressIndicator(value: chance / 100, color: color),
    );
  }
}
