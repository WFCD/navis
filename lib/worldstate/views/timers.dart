import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/timers/archon_card.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';

class Timers extends StatelessWidget {
  const Timers({super.key});

  @override
  Widget build(BuildContext context) {
    return const TraceableWidget(
      child: _MobileTimers(),
    );
  }
}

class _MobileTimers extends StatelessWidget {
  const _MobileTimers();

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is SolState && n is SolState) {
      final previous = p;
      final next = n;

      return previous.eventsActive != next.eventsActive ||
          previous.arbitrationActive != next.arbitrationActive ||
          // previous.outpostDetected != next.outpostDetected ||
          previous.activeAlerts != next.activeAlerts ||
          previous.activeSales != next.activeSales;
    } else if (n is SystemError) {
      return false;
    }

    return p is! SolState && n is SolState;
  }

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 500.0;

    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (_, state) {
        return ViewLoading(
          isLoading: state is! SolState,
          child: state is! SolState
              ? nil
              : ListView(
                  cacheExtent: cacheExtent,
                  children: [
                    const DailyReward(),
                    const TraderCard(),
                    if (state.eventsActive) const EventCard(),
                    if (state.arbitrationActive) const ArbitrationCard(),
                    // if (state.outpostDetected) const SentientOutpostCard(),
                    const SteelPathCard(),
                    if (state.activeAlerts) const AlertsCard(),
                    const CycleCard(),
                    if (state.activeSales) const DarvoDealCard(),
                    const ArchonHuntCard(),
                    const SortieCard(),
                  ],
                ),
        );
      },
    );
  }
}
