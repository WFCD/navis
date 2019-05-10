import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/screens/syndicates/components/rewards.dart';
import 'package:navis/components/layout.dart';

class EventPanel extends StatefulWidget {
  const EventPanel({this.events});

  final List<Event> events;

  @override
  EventPanelState createState() => EventPanelState();
}

class EventPanelState extends State<EventPanel> {
  final _dotKey = PageStorageBucket();
  int _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
  }

  @override
  void didUpdateWidget(EventPanel oldWidget) {
    if (oldWidget.events != widget.events) _currentPage = 0;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _currentPage = null;

    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _dotKey.writeState(context, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enableDots = widget.events.length <= 1;

    return PageStorage(
        bucket: _dotKey,
        child: SizedBox(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Material(
                color: Theme.of(context).cardColor,
                elevation: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: widget.events
                          .map((e) => EventBuilder(event: e))
                          .toList(),
                      onPageChanged: onPageChanged,
                    )),
                    if (!enableDots)
                      DotsIndicator(
                        numberOfDot: widget.events.length,
                        position: _dotKey.readState(context) ?? _currentPage,
                        dotActiveColor: Theme.of(context).accentColor,
                      )
                  ],
                ))));
  }
}

class EventBuilder extends StatelessWidget {
  const EventBuilder({this.event});

  final Event event;

  Color _healthColor(num health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  Widget _addReward() {
    final reward = event.rewards.firstWhere((r) => r.itemString.isNotEmpty);

    final withCredits = '${reward.itemString} + ${reward.credits}cr';
    final withoutCredits = reward.itemString;

    return StaticBox.text(
        color: Colors.green,
        text: event.rewards.first.credits < 100 ? withoutCredits : withCredits);
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 4);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 4, top: 3),
              child: Text(event.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title)),
          if (event.tooltip != null)
            Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: Text(event.tooltip,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            if (event.victimNode != null)
              StaticBox.text(text: event.victimNode, color: Colors.red),
            space,
            StaticBox.text(
              text:
                  '${(100 - event.currentScore / event.maximumScore * 100).toStringAsFixed(2)}% Remaining',
              color: _healthColor(
                  100 - event.currentScore / event.maximumScore * 100),
            )
          ]),
          space,
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (event.jobs?.isNotEmpty ?? false)
                  ...event.jobs.map((j) => _BuildJob(j)),
                if (event.rewards.isNotEmpty) _addReward()
              ])
        ]);
  }
}

class _BuildJob extends StatelessWidget {
  const _BuildJob(this.job);

  final Jobs job;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 3.0),
      color: Colors.blueAccent[400],
      child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BountyRewards(
                  missionTYpe: job.type,
                  bountyRewards: job.rewardPool.cast<String>()))),
          child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width / 2.2,
              alignment: Alignment.center,
              child: Text(job.type,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center))),
    );
  }
}
