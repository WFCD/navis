import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:worldstate_models/worldstate_models.dart';

class EventInformation extends StatelessWidget {
  const EventInformation({required this.event, super.key});

  final WorldEvent event;

  // List<Reward> eventRewards(List<Reward> rewards, List<InterimStep>? steps) {
  //   final r = List<Reward>.from(rewards);

  //   return r
  //     ..addAll(steps?.map<Reward>((i) => i.reward) ?? [])
  //     ..removeWhere((r) => r.itemString.isEmpty);
  // }

  static const _eventBanner = <String, String>{
    'Thermia Fractures': 'https://wiki.warframe.com/images/OperationBuriedDebtsSplash.png?16aec',
    'DeimosHalloween': 'https://wiki.warframe.com/images/NightsofNaberus.png?123a3',
    'Star Days': 'https://wiki.warframe.com/images/StarDaysPromo.jpg?3a324',
    'GhoulEmergence': 'https://wiki.warframe.com/images/Ghoul_Purge.png?5a862',
  };

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
                    imageUrl: _eventBanner[event.tag] ?? 'https://i.imgur.com/CNrsc7V.png',
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
                    // interimSteps: event.interimSteps,
                    // rewards: event.reward,
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
