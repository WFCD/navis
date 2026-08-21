import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/cubit/cubit.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class EventStatus extends StatelessWidget {
  const EventStatus({super.key, required this.event});

  final WorldEvent event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final category = context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.secondary);
    final tooltipStyle = context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);

    final hasHealth = event.health != null || event.goal != null && event.goal != 0;

    final tooltip = event.tooltip;
    final node = event.victimNode ?? event.node ?? '';
    final rewards = event.rewards;

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (tooltip != null) _EventTooltip(tooltip: tooltip),
            CategoryTitle(title: l10n.eventStatus, style: category, contentPadding: EdgeInsets.zero),
            RowItem(
              text: Text(l10n.eventStatusNode, style: tooltipStyle),
              child: ColoredContainer.text(text: node),
            ),
            RowItem(
              text: Text(l10n.eventStatusEta, style: tooltipStyle),
              child: CountdownTimer(tooltip: l10n.countdownTooltip(event.expiry), expiry: event.expiry),
            ),
            if (hasHealth)
              _EventProgress(
                scoreLocTag: event.scoreLocTag,
                health: event.health?.toDouble(),
                currentScore: event.count,
                maxScore: event.goal,
              ),
            if (rewards != null && rewards.isNotEmpty) ...{
              CategoryTitle(title: l10n.eventRewards, style: category, contentPadding: EdgeInsets.zero),
              Gaps.gap2,
              _RewardTiles(rewards: rewards),
            },
          ],
        ),
      ),
    );
  }
}

class _EventTooltip extends StatelessWidget {
  const _EventTooltip({required this.tooltip});

  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tooltipStyle = context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);
    final category = context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.secondary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CategoryTitle(title: l10n.eventDescription, style: category, contentPadding: EdgeInsets.zero),
        Text(tooltip, style: tooltipStyle),
      ],
    );
  }
}

class _EventProgress extends StatelessWidget {
  const _EventProgress({this.scoreLocTag, this.health, this.currentScore, this.maxScore});

  final String? scoreLocTag;
  final double? health;
  final int? currentScore;
  final int? maxScore;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat().format;
    final tooltipStyle = context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);

    if (maxScore != null && maxScore != 0) {
      return RowItem(
        text: Text(scoreLocTag ?? context.l10n.eventStatusProgress, style: tooltipStyle),
        child: ColoredContainer.text(text: '${format(currentScore)}/${format(maxScore)}'),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          '${scoreLocTag ?? context.l10n.defaultScoreLocTagText}: ${(health! * 100).toStringAsFixed(2)}%',
          style: tooltipStyle,
        ),
        LinearProgressIndicator(value: health),
      ],
    );
  }
}

class _RewardTiles extends StatelessWidget {
  const _RewardTiles({required this.rewards});

  final List<WorldEventReward> rewards;

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ItemsRepository>();
    final rewards = <Widget>[];

    for (final reward in this.rewards) {
      final items = reward.reward.items;
      final title = items!.first;

      String? subtitle;
      if (items.length > 1) subtitle = items.skip(1).join(' + ');

      rewards.add(
        BlocProvider(
          create: (context) => ItemCubit(repository)..fetchItem(title),
          child: _RewardTile(reward: title, subRewards: subtitle, requiredScore: reward.requiredScore),
        ),
      );
    }

    return Column(spacing: 8, children: rewards);
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({required this.reward, required this.subRewards, required this.requiredScore});

  final String reward;
  final String? subRewards;
  final int requiredScore;

  @override
  Widget build(BuildContext context) {
    final scoreStye = context.textTheme.labelLarge;

    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final item = switch (state) {
          ItemStoreFetchSuccess(:final item) => item,
          _ => null,
        };

        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: item != null ? CachedNetworkImage(imageUrl: item.imageName.warframeItemsCdn(), width: 50) : null,
          title: Text(item?.name ?? reward),
          subtitle: subRewards != null ? Text(subRewards!) : null,
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.eventRewardRequireScoreText, style: scoreStye),
              Text(NumberFormat().format(requiredScore), style: scoreStye),
            ],
          ),
        );
      },
    );
  }
}
