import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';

import 'event/wmd.dart';
import 'event/ostron_event.dart';

class Event extends StatelessWidget {
  final Events event;

  Event({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool eventCheck =
        event.description.contains(RegExp('(Fomorian)|(Razorback)'));

    switch (event.description) {
      case 'Ghoul Purge':
        return BountyEvent(event: event);
      case 'Relay Title':
        return Container();
      default:
        if (eventCheck)
          return WMD(event: event);
        else
          return Container(height: 0.0, width: 0.0);
    }
  }
}
