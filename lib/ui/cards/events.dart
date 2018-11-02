import 'package:flutter/material.dart';
import 'package:navis/models/worldstate_model/events.dart';

import 'event/wmd.dart';

class Event extends StatefulWidget {
  final Events event;

  Event({Key key, @required this.event}) : super(key: key);

  @override
  _Event createState() => _Event();
}

class _Event extends State<Event> {
  @override
  Widget build(BuildContext context) {
    bool eventCheck = widget.event.description.contains('Fomorian') ||
        widget.event.description.contains('Razorback');

    switch (widget.event.description) {
      case 'Ghoul Purge':
        return Container();
      case 'Relay Title':
        return Container();
      default:
        if (eventCheck)
          return WMD(event: widget.event);
        else
          return Container();
    }
  }
}
