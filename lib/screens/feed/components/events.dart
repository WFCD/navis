import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/screens/syndicates/components/rewards.dart';
import 'package:navis/components/layout.dart';

import 'package:rxdart/rxdart.dart';

class EventPanel extends StatefulWidget {
  const EventPanel({this.events});

  final List<Event> events;

  @override
  EventPanelState createState() => EventPanelState();
}

class EventPanelState extends State<EventPanel> {
  StreamController<int> _currentPage;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = BehaviorSubject<int>();
    pageController = PageController(initialPage: 0);

    _currentPage.sink.add(0);
  }

  @override
  void didUpdateWidget(EventPanel oldWidget) {
    if (oldWidget.events.length != widget.events.length) {
      _currentPage.sink.add(0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _currentPage?.close();
    pageController?.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    _currentPage.sink.add(index);
  }

  @override
  Widget build(BuildContext context) {
    final bool enableDots = widget.events.length <= 1;

    return Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 6,
          child: PageStorage(
              bucket: PageStorageBucket(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ...widget.events.map((e) => EventBuilder(event: e))
                    ],
                    onPageChanged: onPageChanged,
                  )),
                  if (!enableDots)
                    StreamBuilder<int>(
                      stream: _currentPage.stream,
                      initialData: 0,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        return Indicator(
                          numberOfDot: widget.events.length,
                          position: snapshot.data,
                          dotSize: const Size.square(9.0),
                          dotActiveSize: const Size(25.0, 9.0),
                          dotActiveShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          dotActiveColor: Theme.of(context).accentColor,
                        );
                      },
                    ),
                ],
              )),
        ));
  }
}

class EventBuilder extends StatelessWidget {
  const EventBuilder({this.event});

  final Event event;

  Color _healthColor() {
    double health;
    try {
      health = event?.health != null
          ? double.parse(event?.health)
          : (100 - event.currentScore / event.maximumScore * 100).toDouble();
    } catch (err) {
      health = 100.0;
    }

    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  String _healthText() {
    String health;

    if (event?.health != null)
      health = event?.health;
    else if (event.currentScore != null && event.maximumScore != null) {
      health = (100 - (event.currentScore / event.maximumScore) * 100)
          .toStringAsFixed(2);
    } else
      health = 'unknown';

    return '$health% Remaining';
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
              text: _healthText(),
              color: _healthColor(),
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
