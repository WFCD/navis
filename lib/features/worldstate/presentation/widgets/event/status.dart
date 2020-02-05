import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/widgets/event/guide_player.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class EventStatus extends StatelessWidget {
  const EventStatus({Key key, this.description, this.tooltip, this.rewards})
      : super(key: key);

  final String description, tooltip;
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
          Chip(
            label: Text(r.first.trim()),
            // backgroundColor: Colors.green,
          ),
          Chip(
            label: Text(r.last.trim()),
            // backgroundColor: Colors.green,
          )
        ]);
      } else {
        rewards.add(Chip(
          label: Text(reward.itemString),
          // backgroundColor: Colors.green,
        ));
      }
    }

    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final category = theme.textTheme.subhead.copyWith(color: theme.accentColor);
    final tooltipStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(fontStyle: FontStyle.italic, fontSize: 17);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _addCategory('Description', category),
              const SizedBox(height: 2.0),
              Text(tooltip, style: tooltipStyle),
              const SizedBox(height: 16.0),
              _addCategory('Rewards', category),
              const SizedBox(height: 2.0),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 6.0,
                children: _buildRewards(),
              ),
              const SizedBox(height: 20.0),
              _addCategory('How to guide', category),
              const SizedBox(height: 16.0),
              const EventVideoPlayer(videoID: 'JUCQO6Mywgg')
            ]),
      ),
    );
  }
}
