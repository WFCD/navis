import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';

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
    return BlocBuilder<SolsystemBloc, SolsystemState>(
      buildWhen: (p, n) {
        return (n as SolState)
                .worldstate
                .timestamp
                .difference((p as SolState).worldstate.timestamp) >=
            const Duration(minutes: 30);
      },
      builder: (context, state) {
        if (state is SolState) {
          return ListView(
            cacheExtent: 500,
            children: [
              const DailyReward(),
              const ConstructionProgressCard(),
              if (state.eventsActive) const EventCard(),
              if (state.arbitrationActive) const ArbitrationCard(),
              if (state.outpostDetected) const SentientOutpostCard(),
              const SteelPathCard(),
              if (state.activeAlerts) const AlertsCard(),
              const CycleCard(),
              const TraderCard(),
              if (state.activeSales) const DarvoDealCard(),
              const SortieCard()
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
