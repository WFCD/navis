import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/alerts_card.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/arbitration_card.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/feed_cards.dart';

class HomeFeedPage extends StatelessWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<SolsystemBloc>(context).update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            final worldstate = state.worldstate;

            return ListView(
              children: <Widget>[
                if (worldstate.eventsActive)
                  EventCard(events: worldstate.events),
                if (worldstate.acolytesActive)
                  AcolyteCard(enemies: worldstate.persistentEnemies),
                if (worldstate.arbitrationActive)
                  ArbitrationCard(arbitration: worldstate.arbitration),
                if (worldstate.alertsActive)
                  AlertsCard(alerts: worldstate.alerts),
                CycleCard(cycles: <CycleEntry>[
                  CycleEntry(
                    name: 'Earth Cycle',
                    cycle: worldstate.earthCycle,
                  ),
                  CycleEntry(
                    name: 'Cetus Cycle',
                    cycle: worldstate.cetusCycle,
                  ),
                  CycleEntry(
                    name: 'Vallis Cycle',
                    cycle: worldstate.vallisCycle,
                  )
                ]),
                TraderCard(trader: worldstate.voidTrader),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
