import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class BountyStage extends StatelessWidget {
  const BountyStage({
    super.key,
    required this.stage,
    required this.maxStage,
    required this.color,
    required this.rewards,
  });

  final int stage;
  final int maxStage;
  final Color color;
  final List<RewardDrop> rewards;

  @override
  Widget build(BuildContext context) {
    rewards.sort(
      (a, b) => Rarity.values
          .byName(a.rarity.toLowerCase())
          .index
          .compareTo(Rarity.values.byName(b.rarity.toLowerCase()).index),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (maxStage >= 3)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.stageText,
                  style: context.textTheme.titleLarge,
                ),
                Gaps.gap6,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < maxStage; i++) _StageDimond(enable: i < stage, color: color),
                  ],
                ),
              ],
            ),
          ),
        ...rewards.map((r) => _BountyReward(reward: r)),
      ],
    );
  }
}

class _BountyReward extends StatelessWidget {
  const _BountyReward({required this.reward});

  final RewardDrop reward;

  @override
  Widget build(BuildContext context) {
    final count = reward.count;
    final rarity = Rarity.values.byName(reward.rarity.toLowerCase());

    return RewardTile(
      reward: '${count == 1 ? '' : '${count}X '}${reward.item}',
      chance: reward.chance,
      rarity: rarity,
    );
  }
}

class _StageDimond extends StatelessWidget {
  const _StageDimond({required this.enable, this.color});

  final bool enable;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.secondary;
    const size = Size.square(12);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Transform.rotate(
        angle: 75 * pi / 100,
        child: SizedBox.fromSize(
          size: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: color),
              color: enable ? color : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
