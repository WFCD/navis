import 'package:flutter/material.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _EventHeader(
            description: event.description,
            tooltip: event.tooltip,
          ),
          const SizedBox(height: 16),
          _EventMiddle(
            victimNode: event.victimNode,
            health: event.eventHealth.toDouble() ?? event.health,
            rewards: event.rewards,
            expiry: event.expiry,
          ),
          const SizedBox(height: 4),
          _EventFooter(
            affiliatedWith: event.affiliatedWith,
            rewards: event.eventRewards ?? event.health,
            jobs: event?.jobs,
          ),
        ],
      ),
    );
  }
}

class _EventHeader extends StatelessWidget {
  const _EventHeader({
    Key key,
    @required this.description,
    @required this.tooltip,
  }) : super(key: key);

  final String description, tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontSize: SizeConfig.widthMultiplier * 6),
            ),
          ),
          if (tooltip != null)
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: Text(
                tooltip,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: SizeConfig.widthMultiplier * 3.2),
              ),
            ),
        ],
      ),
    );
  }
}

class _EventMiddle extends StatelessWidget {
  const _EventMiddle({
    Key key,
    @required this.victimNode,
    @required this.health,
    @required this.rewards,
    @required this.expiry,
  }) : super(key: key);

  final String victimNode;
  final double health;
  final List<Reward> rewards;
  final DateTime expiry;

  Color _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = SizeConfig.widthMultiplier * 3.5;
    final style =
        Theme.of(context).textTheme.subhead.copyWith(fontSize: fontSize);

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      if (victimNode != null)
        StaticBox.text(
          text: victimNode,
          color: Colors.red,
          style: style,
        ),
      if (rewards.where((r) => r.credits > 0).isNotEmpty)
        StaticBox.text(
          text: '${rewards.firstWhere((r) => r.credits > 0).credits}cr',
          color: Theme.of(context).primaryColor,
          style: style,
        ),
      const SizedBox(height: 4),
      if (health != null)
        StaticBox.text(
          text: '${health.toStringAsFixed(2)}% remaining',
          color: _healthColor(health),
          style: style,
        )
      else
        CountdownBox(expiry: expiry),
    ]);
  }
}

class _EventFooter extends StatelessWidget {
  const _EventFooter({
    Key key,
    @required this.affiliatedWith,
    @required this.rewards,
    @required this.jobs,
  }) : super(key: key);

  final String affiliatedWith;
  final List<String> rewards;
  final List<Job> jobs;

  Widget _addReward(TextStyle style) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (String r in rewards)
          StaticBox.text(text: r, style: style, color: Colors.green)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = SizeConfig.widthMultiplier * 3.9;
    final style =
        Theme.of(context).textTheme.subhead.copyWith(fontSize: fontSize);

    if (jobs?.isNotEmpty ?? false) {
      return FlatButton(
        child: const Text('See Bounties'),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier * 15,
          right: SizeConfig.widthMultiplier * 15,
          bottom: SizeConfig.heightMultiplier * 2,
          top: SizeConfig.heightMultiplier * 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onPressed: () {
          final syndicate = Syndicate(name: affiliatedWith, jobs: jobs);

          Navigator.of(context)
              .pushNamed('/syndicate_jobs', arguments: syndicate);
        },
      );
    } else {
      return _addReward(style);
    }
  }
}
