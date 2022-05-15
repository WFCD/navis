import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class EventStatus extends StatelessWidget {
  const EventStatus({
    super.key,
    required this.description,
    this.tooltip,
    required this.node,
    required this.health,
    required this.expiry,
    required this.rewards,
  });

  final String description, node;
  final String? tooltip;
  final double health;
  final DateTime expiry;
  final List<Reward> rewards;

  List<Widget> _buildRewards() {
    final rewards = <Widget>[];

    for (final reward in this.rewards) {
      if (reward.itemString.contains('+')) {
        final r = reward.itemString.split('+');

        rewards.addAll([
          Chip(label: Text(r.first.trim())),
          Chip(label: Text(r.last.trim()))
        ]);
      } else {
        rewards.add(Chip(label: Text(reward.itemString)));
      }
    }

    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final category =
        theme.textTheme.subtitle1?.copyWith(color: theme.colorScheme.secondary);
    final tooltipStyle =
        Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 15);

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (tooltip != null) ...{
              CategoryTitle(
                title: l10n.eventDescription,
                style: category,
                contentPadding: EdgeInsets.zero,
              ),
              SizedBoxSpacer.spacerHeight2,
              Text(tooltip!, style: tooltipStyle),
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
              text: Text(l10n.eventStatusProgress, style: tooltipStyle),
              child:
                  ColoredContainer.text(text: '${health.toStringAsFixed(2)} %'),
            ),
            SizedBoxSpacer.spacerHeight8,
            RowItem(
              text: Text(l10n.eventStatusEta, style: tooltipStyle),
              child: CountdownTimer(
                tooltip: l10n.countdownTooltip(expiry),
                expiry: expiry,
              ),
            ),
            if (rewards.isNotEmpty) ...{
              SizedBoxSpacer.spacerHeight20,
              CategoryTitle(
                title: l10n.eventRewards,
                style: category,
                contentPadding: EdgeInsets.zero,
              ),
              SizedBoxSpacer.spacerHeight2,
              Wrap(
                spacing: 6,
                children: _buildRewards(),
              ),
            }
          ],
        ),
      ),
    );
  }
}
