import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/l10n/localizations.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class EventStatus extends StatelessWidget {
  const EventStatus({
    Key key,
    this.description,
    this.tooltip,
    this.node,
    this.health,
    this.expiry,
    this.rewards,
  }) : super(key: key);

  final String description, tooltip, node;
  final double health;
  final DateTime expiry;
  final List<Reward> rewards;

  Widget _addCategory(String category, TextStyle style) {
    return CategoryTitle(
      title: category,
      style: style,
      addPadding: false,
    );
  }

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

  Widget _buildStatus() {
    return Container(
      child: Column(
        children: <Widget>[
          RowItem(
            text: const Text('Node'),
            child: StaticBox.text(text: node),
          ),
          const SizedBox(height: 8.0),
          RowItem(
            text: const Text('Progress'),
            child: StaticBox.text(text: '${health.toStringAsFixed(2)} %'),
          ),
          const SizedBox(height: 8.0),
          RowItem(
            text: const Text('Time left (ETA)'),
            child: CountdownTimer(expiry: expiry),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = NavisLocalizations.of(context);

    final category = theme.textTheme.subhead.copyWith(color: theme.accentColor);
    final tooltipStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(fontStyle: FontStyle.italic, fontSize: 15);

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _addCategory(localization.eventDescription, category),
            const SizedBox(height: 2.0),
            Text(tooltip, style: tooltipStyle),
            const SizedBox(height: 20.0),
            _addCategory(localization.eventStatus, category),
            _buildStatus(),
            const SizedBox(height: 20.0),
            _addCategory('Rewards', category),
            const SizedBox(height: 2.0),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 6.0,
              children: _buildRewards(),
            ),
          ],
        ),
      ),
    );
  }
}
