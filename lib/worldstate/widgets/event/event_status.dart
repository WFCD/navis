import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class EventStatus extends StatelessWidget {
  const EventStatus({
    super.key,
    required this.description,
    this.tooltip,
    required this.node,
    required this.health,
    required this.scoreLocTag,
    required this.expiry,
    required this.rewards,
  });

  final String description;
  final String node;
  final String? tooltip;
  final double? health;
  final String? scoreLocTag;
  final DateTime expiry;
  final List<Reward> rewards;

  @override
  Widget build(BuildContext context) {
    const fixedString = 2;
    final l10n = context.l10n;
    final category = context.textTheme.titleMedium
        ?.copyWith(color: context.theme.colorScheme.secondary);
    final tooltipStyle =
        context.theme.textTheme.titleSmall?.copyWith(fontSize: 15);

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (tooltip != null) ...{
              CategoryTitle(
                title: l10n.eventDescription,
                style: category,
                contentPadding: EdgeInsets.zero,
              ),
              SizedBoxSpacer.spacerHeight2,
              Text(tooltip ?? '', style: tooltipStyle),
              SizedBoxSpacer.spacerHeight20,
            },
            CategoryTitle(
              title: l10n.eventStatus,
              style: category,
              contentPadding: EdgeInsets.zero,
            ),
            RowItem(
              text: Text(l10n.eventStatusNode, style: tooltipStyle),
              child: ColoredContainer.text(text: node),
            ),
            SizedBoxSpacer.spacerHeight8,
            RowItem(
              text: Text(l10n.eventStatusEta, style: tooltipStyle),
              child: CountdownTimer(
                tooltip: l10n.countdownTooltip(expiry),
                expiry: expiry,
              ),
            ),
            SizedBoxSpacer.spacerHeight24,
            if (health != null && !health!.isNaN && !health!.isInfinite)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (scoreLocTag != null)
                    Text(
                      '$scoreLocTag: ${health!.toStringAsFixed(fixedString)}%',
                      style: tooltipStyle,
                    ),
                  SizedBoxSpacer.spacerHeight4,
                  LinearProgressIndicator(value: health! / 100),
                ],
              ),
            if (rewards.isNotEmpty) ...{
              SizedBoxSpacer.spacerHeight20,
              CategoryTitle(
                title: l10n.eventRewards,
                style: category,
                contentPadding: EdgeInsets.zero,
              ),
              SizedBoxSpacer.spacerHeight2,
              _RewardChips(rewards: rewards),
            },
          ],
        ),
      ),
    );
  }
}

class _RewardChips extends StatelessWidget {
  const _RewardChips({required this.rewards});

  final List<Reward> rewards;

  @override
  Widget build(BuildContext context) {
    final rewards = <Widget>[];

    for (final reward in this.rewards) {
      if (reward.itemString.contains('+')) {
        final r = reward.itemString.split('+');

        rewards.addAll([
          Chip(label: Text(r.first.trim())),
          Chip(label: Text(r.last.trim())),
        ]);
      } else {
        rewards.add(Chip(label: Text(reward.itemString)));
      }
    }

    return Wrap(spacing: 6, children: rewards);
  }
}
