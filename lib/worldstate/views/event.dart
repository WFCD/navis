import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:warframe_common/warframe_common.dart';

class EventInformation extends StatelessWidget {
  const new({required this.event, super.key});

  final WorldEvent event;

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.sizeOf(context).height / 100) * 25;

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
                iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    event.description,
                    style: TextTheme.of(context).titleMedium?.copyWith(color: Colors.white),
                  ),
                  background: CachedNetworkImage(
                    imageUrl: eventBackkgrounds[event.tag] ?? 'https://i.imgur.com/CNrsc7V.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).colorScheme.shadow.withValues(alpha: .5),
                    colorBlendMode: BlendMode.darken,
                    memCacheHeight: (height * MediaQuery.devicePixelRatioOf(context)).toInt(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(<Widget>[
                  EventStatus(event: event),
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
