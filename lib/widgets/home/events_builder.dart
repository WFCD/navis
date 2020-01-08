import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'events_widget.dart';

class EventsPanel extends StatelessWidget {
  const EventsPanel({Key key, this.events}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: PageStorage(
        key: eventsKey,
        bucket: eventsBucket,
        child: Carousel(
          dotCount: events.length,
          enableIndicator: events.length > 1,
          children: events.map((e) => EventWidget(event: e)).toList(),
        ),
      ),
    );
  }
}
