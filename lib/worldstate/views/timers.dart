import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/timers.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';

class Timers extends TraceableStatelessWidget {
  const Timers({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileTimers();
  }
}

class MobileTimers extends StatelessWidget {
  const MobileTimers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) {
        if (p is SolState && n is SolState) {
          final previous = p;
          final next = n;

          return previous.eventsActive != next.eventsActive ||
              previous.arbitrationActive != next.arbitrationActive ||
              previous.outpostDetected != next.outpostDetected ||
              previous.activeAlerts != next.activeAlerts ||
              previous.activeSales != next.activeSales;
        } else if (n is SystemError) {
          return false;
        }

        return p is! SolState && n is SolState;
      },
      builder: (_, state) {
        return ViewLoading(
          isLoading: state is! SolState,
          child: state is! SolState
              ? nil
              : ListView(
                  cacheExtent: 500,
                  children: [
                    const DailyReward(),
                    const TraderCard(),
                    if (state.eventsActive) const EventCard(),
                    if (state.arbitrationActive) const ArbitrationCard(),
                    if (state.outpostDetected) const SentientOutpostCard(),
                    const SteelPathCard(),
                    if (state.activeAlerts) const AlertsCard(),
                    const CycleCard(),
                    if (state.activeSales) const DarvoDealCard(),
                    const SortieCard()
                  ],
                ),
        );
      },
    );
  }
}
