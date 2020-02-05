import 'package:flutter/material.dart';
import 'package:navis/core/widgets/panel.dart';
import 'package:navis/features/worldstate/presentation/pages/event.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({Key key, this.events = const []}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Column(children: <Widget>[
        for (final event in events)
          ListTile(
            title: Text(event.description),
            subtitle: Text(event.tooltip),
            trailing: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EventInformation.route, arguments: event);
              },
              child: const Text('See details'),
            ),
          )
      ]),
    );
  }
}
