import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'event_builder.dart';

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
            height: 150,
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
