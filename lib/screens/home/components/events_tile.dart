import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/widgets.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/utils/worldstate_utils.dart';

import 'events_widget.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: PageStorage(
        key: eventsKey,
        bucket: eventsBucket,
        child: BlocBuilder(
            bloc: BlocProvider.of<WorldstateBloc>(context),
            condition: (WorldStates previous, WorldStates current) =>
                compareList(
                  previous: previous.worldstate?.events,
                  current: current.worldstate?.events,
                ),
            builder: (BuildContext context, WorldStates state) {
              final events = state.worldstate?.events ?? [];

              return Carousel(
                dotCount: events.length,
                enableIndicator: events.length > 1,
                children: events.map((e) => EventStyle(event: e)).toList(),
              );
            }),
      ),
    );
  }
}
