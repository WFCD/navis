import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../injection_container.dart';
import '../../data/datasources/event_info_parser.dart';
import '../widgets/event/event_bounties.dart';
import '../widgets/event/event_status.dart';

class EventInformation extends TraceableStatelessWidget {
  const EventInformation({Key? key}) : super(key: key);

  static const route = 'event_information';

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final event = ModalRoute.of(context)?.settings.arguments! as Event;
    final eventInfo = sl<EventInfoParser>().getEventInfo(event.description);

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: (MediaQuery.of(context).size.height / 100) * 25,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(event.description),
            background: CachedNetworkImage(
              imageUrl: eventInfo.keyArt,
              fit: BoxFit.cover,
              color: const Color.fromRGBO(34, 34, 34, .4),
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
              health: event.eventHealth ?? 0.0,
              expiry: event.expiry ?? DateTime.now().add(59.seconds),
              rewards: event.eventRewards,
            ),
            if (event.jobs != null) EventBounties(jobs: event.jobs!),
            // if (eventInfo.howTos.isNotEmpty)
            //   EventVideoPlayer(
            //     id: eventInfo.howTos.first.id,
            //     profileThumbnail: eventInfo.howTos.first.pThumbnail,
            //   )
          ]),
        ),
      ]),
    );
  }
}
