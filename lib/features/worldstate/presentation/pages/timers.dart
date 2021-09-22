import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:navis/core/widgets/bloc_progress_loader.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/timers/timers.dart';

class Timers extends TraceableStatelessWidget {
  const Timers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MobileTimers();
  }
}

class MobileTimers extends StatelessWidget {
  const MobileTimers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilerProgressLoader<SolsystemBloc, SolsystemState>(
      buildWhen: (p, n) {
        return (n as SolState)
                .worldstate
                .timestamp
                .difference((p as SolState).worldstate.timestamp) >=
            const Duration(minutes: 30);
      },
      isLoaded: (state) => state is SolState,
      builder: (context, state) {
        final _state = state as SolState;

        return ListView(
          cacheExtent: 500,
          children: [
            const DailyReward(),
            const ConstructionProgressCard(),
            if (_state.eventsActive) const EventCard(),
            if (_state.arbitrationActive) const ArbitrationCard(),
            if (_state.outpostDetected) const SentientOutpostCard(),
            const SteelPathCard(),
            if (_state.activeAlerts) const AlertsCard(),
            const CycleCard(),
            const TraderCard(),
            if (_state.activeSales) const DarvoDealCard(),
            const SortieCard()
          ],
        );
      },
    );
  }
}
