import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class Timers extends StatelessWidget {
  const Timers({super.key});

  @override
  Widget build(BuildContext context) {
    return const TraceableWidget(child: _MobileTimers());
  }
}

class _MobileTimers extends StatelessWidget {
  const _MobileTimers();

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 500.0;

    return BlocSelector<WorldstateBloc, WorldState, Worldstate?>(
      selector:
          (state) => switch (state) {
            WorldstateSuccess() => state.seed,
            _ => null,
          },
      builder: (_, worldstate) {
        return ViewLoading(
          isLoading: worldstate == null,
          child: ListView(
            key: const PageStorageKey('timers'),
            shrinkWrap: true,
            cacheExtent: cacheExtent,
            children: [
              const DailyReward(),
              const TraderCard(),
              if (worldstate?.eventsActive ?? false) const EventCard(),
              if (worldstate?.arbitrationActive ?? false) const ArbitrationCard(),
              // if (state.outpostDetected) const SentientOutpostCard(),
              const SteelPathCard(),
              if (worldstate?.activeAlerts ?? false) const AlertsCard(),
              const CycleCard(),
              const DuviriCircuit(),
              if (worldstate?.deepArchimedeaActive ?? false) const ArchimedeaCard(),
              if (worldstate?.activeSales ?? false) const DarvoDealCard(),
              const ArchonHuntCard(),
              const SortieCard(),
            ],
          ),
        );
      },
    );
  }
}
