import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:worldstate_models/worldstate_models.dart';

class EventInformation extends StatelessWidget {
  const EventInformation({required this.event, super.key});

  final WorldEvent event;

  @override
  Widget build(BuildContext context) {
    final height = (context.mediaQuery.size.height / 100) * 25;

    return TraceableWidget(
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: height,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(event.description),
                  background: CachedNetworkImage(
                    imageUrl: eventBackkgrounds[event.tag] ?? 'https://i.imgur.com/CNrsc7V.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).colorScheme.shadow.withValues(alpha: .5),
                    colorBlendMode: BlendMode.darken,
                    memCacheHeight: (height * context.mediaQuery.devicePixelRatio).toInt(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(<Widget>[
                  EventStatus(
                    description: event.description,
                    tooltip: event.tooltip,
                    node: event.victimNode ?? event.node ?? '',
                    health: event.health?.toDouble(),
                    currentScore: event.count,
                    maxScore: event.goal,
                    scoreLocTag: event.scoreLocTag,
                    expiry: event.expiry,
                    rewards: event.rewards ?? [],
                  ),
                  if (event.bounties != null) EventBounties(jobs: event.bounties!),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
