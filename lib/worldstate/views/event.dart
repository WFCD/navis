import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/widgets/event/event_bounties.dart';
import 'package:navis/worldstate/widgets/event/event_status.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class EventInformation extends TraceableStatelessWidget {
  const EventInformation({super.key});

  static const route = 'event_information';

  @override
  Widget build(BuildContext context) {
    // There are checks in othere places that ensure this is a non null
    // Event type.
    // ignore: cast_nullable_to_non_nullable
    final event = ModalRoute.of(context)?.settings.arguments as Event;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            // It's just what works for the style.
            // ignore: no-magic-number
            expandedHeight: (MediaQuery.of(context).size.height / 100) * 25,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(event.description),
              background: CachedNetworkImage(
                imageUrl: 'https://i.imgur.com/CNrsc7V.png',
                fit: BoxFit.cover,
                color: const Color.fromRGBO(34, 34, 34, 0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(<Widget>[
              EventStatus(
                description: event.description,
                tooltip: event.tooltip ?? '',
                node: event.victimNode ?? event.node ?? '',
                health: event.eventHealth,
                expiry: event.expiry ?? DateTime.now().add(kDelayLong),
                rewards: event.eventRewards,
              ),
              // Already being checked for null.
              // ignore: avoid-non-null-assertion
              if (event.jobs != null) EventBounties(jobs: event.jobs!),
            ]),
          ),
        ],
      ),
    );
  }
}
