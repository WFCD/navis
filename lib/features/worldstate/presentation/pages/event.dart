import 'package:flutter/material.dart';
import 'package:navis/features/worldstate/presentation/widgets/event/status.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class EventInformation extends StatelessWidget {
  const EventInformation({Key key}) : super(key: key);

  static const route = 'event_information';

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context).settings.arguments as Event;

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(title: Text(event.description)),
        SliverPadding(
          padding: const EdgeInsets.only(top: 16.0),
          sliver: SliverToBoxAdapter(
              child: EventStatus(
            description: event.description,
            tooltip: event.tooltip,
            rewards: event.eventRewards,
          )),
        )
      ]),
    );
  }
}
