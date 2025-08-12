import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef EventReward = ({Reward reward, int requiredScore});

List<EventReward> eventRewards(List<Reward> rewards, List<InterimStep>? interimSteps) {
  final r = <EventReward>[];

  if (interimSteps != null) {
    for (final step in interimSteps) {
      r.add((reward: step.reward, requiredScore: step.goal));
    }
  }

  for (final reward in rewards) {
    if (reward.itemString.isEmpty) continue;

    final interimScore = r[r.length - 1].requiredScore;

    r.add((reward: reward, requiredScore: interimScore == 75 ? interimScore + 25 : interimScore * 2));
  }

  return r;
}

class EventStatus extends StatelessWidget {
  const EventStatus({
    super.key,
    required this.description,
    this.tooltip,
    required this.node,
    required this.health,
    this.currentScore,
    this.maxScore,
    required this.scoreLocTag,
    this.interimSteps,
    required this.rewards,
    required this.expiry,
  });

  final String description;
  final String node;
  final String? tooltip;
  final double? health;
  final int? currentScore;
  final int? maxScore;
  final String? scoreLocTag;
  final List<InterimStep>? interimSteps;
  final List<Reward> rewards;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final category = context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.secondary);
    final tooltipStyle = context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);

    final hasHealth = health != null || maxScore != null && maxScore != 0;
    final hasRewards = (interimSteps?.isNotEmpty ?? false) || rewards.isNotEmpty;

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (tooltip != null) _EventTooltip(tooltip: tooltip!),
            CategoryTitle(title: l10n.eventStatus, style: category, contentPadding: EdgeInsets.zero),
            RowItem(text: Text(l10n.eventStatusNode, style: tooltipStyle), child: ColoredContainer.text(text: node)),
            RowItem(
              text: Text(l10n.eventStatusEta, style: tooltipStyle),
              child: CountdownTimer(tooltip: l10n.countdownTooltip(expiry), expiry: expiry),
            ),
            if (hasHealth)
              _EventProgress(scoreLocTag: scoreLocTag, health: health, currentScore: currentScore, maxScore: maxScore),
            if (hasRewards) ...{
              Gaps.gap20,
              CategoryTitle(title: l10n.eventRewards, style: category, contentPadding: EdgeInsets.zero),
              Gaps.gap2,
              _RewardTiles(rewards: eventRewards(rewards, interimSteps)),
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
      children: [
        CategoryTitle(title: l10n.eventDescription, style: category, contentPadding: EdgeInsets.zero),
        Padding(padding: const EdgeInsets.only(top: 2, bottom: 20), child: Text(tooltip, style: tooltipStyle)),
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
    final tooltipStyle = context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);

    if (maxScore != null && maxScore != 0) {
      return RowItem(
        text: Text(scoreLocTag ?? 'Progress', style: tooltipStyle),
        child: ColoredContainer.text(text: '$currentScore/$maxScore'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${scoreLocTag ?? 'Progress'}: '
            '${health!.toStringAsFixed(2)}%',
            style: tooltipStyle,
          ),
          Gaps.gap4,
          LinearProgressIndicator(value: health! / 100),
        ],
      ),
    );
  }
}

class _RewardTiles extends StatelessWidget {
  const _RewardTiles({required this.rewards});

  final List<EventReward> rewards;

  @override
  Widget build(BuildContext context) {
    final rewards = <Widget>[];
    final scoreStye = context.textTheme.labelLarge;

    for (final reward in this.rewards) {
      final item = reward.reward.itemString;

      var title = item;
      String? subtitle;
      if (item.contains('+')) {
        final split = item.split('+');

        title = split[0].trim();
        subtitle = split[1].trim();
      }

      rewards.add(
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Required Score', style: scoreStye),
              Text(reward.requiredScore.toString(), style: scoreStye),
            ],
          ),
        ),
      );
    }

    return Column(children: rewards);
  }
}
