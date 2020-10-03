import 'package:flutter/material.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/pages/event.dart';
import 'package:warframestat_api_models/entities.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key key, this.events = const []}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(children: <Widget>[
        for (final event in events)
          ListTile(
            title: Text(event.description),
            subtitle: event.tooltip != null ? Text(event.tooltip) : null,
            trailing: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EventInformation.route, arguments: event);
              },
              child: Text(context.locale.seeDetails),
            ),
          )
      ]),
    );
  }
}
