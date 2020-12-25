import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../pages/event.dart';

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
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button.color),
              ),
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
