import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart' as ws;
import 'package:worldstate_models/worldstate_models.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({super.key, required this.job});

  final SyndicateBounty job;

  @override
  Widget build(BuildContext context) {
    final rewards = job.rewardPool
      ..sort(
        (a, b) => ws.Rarity.values
            .byName(a.rarity.toLowerCase())
            .index
            .compareTo(ws.Rarity.values.byName(b.rarity.toLowerCase()).index),
      );

    return ListTile(
      title: Text(job.type ?? ''),
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
              return ListView(
                controller: scrollController,
                children: rewards.isNotEmpty
                    ? rewards.map((r) => BountyReward(reward: r)).toList()
                    : job.rewards.map(Text.new).toList(),
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
