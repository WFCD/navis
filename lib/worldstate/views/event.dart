import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/event/event_bounties.dart';
import 'package:navis/worldstate/widgets/event/event_status.dart';
import 'package:warframestat_client/warframestat_client.dart';

class EventInformation extends StatelessWidget {
  const EventInformation({required this.event, super.key});

  final WorldEvent event;

  List<Reward> eventRewards(List<Reward> rewards, List<InterimStep>? steps) {
    final r = List<Reward>.from(rewards);

    return r
      ..addAll(steps?.map<Reward>((i) => i.reward) ?? [])
      ..removeWhere((r) => r.itemString.isEmpty);
  }

  static const _eventBanner = <String, String>{
    'Thermia Fractures': 'https://www-static.warframe.com/uploads/thumbnails/'
        '59f071afbbd6d21fda59bc2bd611200_1600x900.png',
    'Operation: Belly of the Beast':
        'https://www-static.warframe.com/uploads/thumbnails'
            '/92a16137ab4635c0d3e222957739eec9_1600x900.png',
  };

  @override
  Widget build(BuildContext context) {
    final height = (context.mediaQuery.size.height / 100) * 25;

    return TraceableWidget(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: height,
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(event.description),
                background: CachedNetworkImage(
                  imageUrl: _eventBanner[event.description] ??
                      'https://i.imgur.com/CNrsc7V.png',
                  fit: BoxFit.cover,
                  color: Colors.grey[350],
                  colorBlendMode: BlendMode.modulate,
                  memCacheHeight:
                      (height * context.mediaQuery.devicePixelRatio).toInt(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(<Widget>[
                SafeArea(
                  child: EventStatus(
                    description: event.description,
                    tooltip: event.tooltip ?? '',
                    node: event.victimNode ?? event.node ?? '',
                    health: event.health?.toDouble(),
                    currentScore: event.currentScore,
                    maxScore: event.maximumScore,
                    scoreLocTag: event.scoreLocTag,
                    expiry: event.expiry,
                    rewards: eventRewards(event.rewards, event.interimSteps),
                  ),
                ),
                if (event.jobs != null && event.jobs!.isNotEmpty)
                  SafeArea(child: EventBounties(jobs: event.jobs!)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
