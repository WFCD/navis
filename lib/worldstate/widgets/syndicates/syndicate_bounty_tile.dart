import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart' as ws;
import 'package:worldstate_models/worldstate_models.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({super.key, required this.color, required this.job});

  final Color color;
  final SyndicateBounty job;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${job.type!}${job.isVault ?? false ? ' - Isolation Vault' : ''}'),
      subtitle: Text(context.l10n.levelInfo(job.minLevel, job.maxLevel)),
      trailing: _Standing(standing: job.standing),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              if (job.rewards.length < 2) return Center(child: Text(job.rewards[0]));

              return ListView(
                controller: scrollController,
                children: job.rewardPool
                    .map(
                      (bounty) => SyndicateBountyStage(
                        stage: bounty.stage,
                        maxStage: job.rewardPool.length,
                        rewards: bounty.rewards,
                        color: color,
                      ),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class _Standing extends StatelessWidget {
  const _Standing({required this.standing});

  final int standing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          NumberFormat().format(standing),
          style: context.textTheme.labelLarge,
        ),
        const Icon(WarframeIcons.standing, size: 20),
      ],
    );
  }
}

class SyndicateBountyStage extends StatelessWidget {
  const SyndicateBountyStage({
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
      (a, b) => ws.Rarity.values
          .byName(a.rarity.toLowerCase())
          .index
          .compareTo(ws.Rarity.values.byName(b.rarity.toLowerCase()).index),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Stage',
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
        ...rewards.map((r) => BountyReward(reward: r)),
      ],
    );
  }
}

class BountyReward extends StatelessWidget {
  const BountyReward({super.key, required this.reward});

  final RewardDrop reward;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final count = reward.count;
    final color = ws.Rarity.values.byName(reward.rarity.toLowerCase()).toColor();

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${count == 1 ? '' : '${count}X '}${reward.item}',
            style: context.textTheme.titleMedium,
          ),
          Text(
            '${reward.chance}%',
            style: textTheme.bodyMedium?.copyWith(color: color),
          ),
        ],
      ),
      subtitle: LinearProgressIndicator(value: reward.chance / 100, color: color),
      dense: true,
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
    const size = Size.square(16);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
