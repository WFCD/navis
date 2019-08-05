import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/screens/syndicates/components/syndicate_missions.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldstate_model/worldstate_models.dart';
import 'package:worldstate_model/worldstate_objects.dart';

class EventPanel extends StatefulWidget {
  const EventPanel({Key key}) : super(key: key);
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
    return BlocBuilder(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      condition: (WorldStates previous, WorldStates current) =>
          compareList(previous.worldstate?.events, current.worldstate?.events),
      builder: (BuildContext context, WorldStates state) {
        final events = state.worldstate?.events ?? [];

        return Container(
            height: 200,
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
                          ...events.map((e) => EventBuilder(event: e))
                        ],
                        onPageChanged: onPageChanged,
                      )),
                      if (events.length > 1)
                        StreamBuilder<int>(
                          stream: _currentPage.stream,
                          initialData: 0,
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            return Indicator(
                              numberOfDot: events.length,
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
      },
    );
  }
}

class EventBuilder extends StatelessWidget {
  const EventBuilder({this.event});

  final Event event;

  Color _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  Widget _addReward(List<String> rewards) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (String r in rewards) StaticBox.text(color: Colors.green, text: r)
      ],
    );
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
            if (event.eventHealth != null)
              StaticBox.text(
                text: '${event.eventHealth} remaining',
                color: _healthColor(event.eventHealth),
              )
            else
              CountdownBox(expiry: event.expiry)
          ]),
          space,
          if (event.jobs?.isNotEmpty ?? false)
            FlatButton(
              child: const Text('See Bounties'),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              onPressed: () => _navigateToBounties(context, event.jobs),
            )
          else
            _addReward(event.eventRewards)
        ]);
  }
}

void _navigateToBounties(BuildContext context, List<Job> jobs) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => SyndicateJobs(
        faction: OpenWorldFactions.cetus,
        jobs: jobs,
      ),
    ),
  );
}
