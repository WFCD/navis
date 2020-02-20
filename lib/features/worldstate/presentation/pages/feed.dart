import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/feed_cards.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class HomeFeedPage extends StatelessWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  List<CycleEntry> _buildCycles(Worldstate worldstate) {
    const size = 30.0;

    final solCycle = <Icon>[
      Icon(NavisSysIcons.sun, color: Colors.amber, size: size),
      Icon(NavisSysIcons.moon, color: Colors.blue, size: size)
    ];

    final tempCycle = <Icon>[
      Icon(NavisSysIcons.waves, color: Colors.red, size: size),
      Icon(NavisSysIcons.snow, color: Colors.blue, size: size)
    ];

    return <CycleEntry>[
      CycleEntry(
        name: 'Earth Cycle',
        states: solCycle,
        cycle: worldstate.earthCycle,
      ),
      CycleEntry(
        name: 'Cetus Cycle',
        states: solCycle,
        cycle: worldstate.cetusCycle,
      ),
      CycleEntry(
        name: 'Vallis Cycle',
        states: tempCycle,
        cycle: worldstate.vallisCycle,
      )
    ];
  }

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
                CycleCard(cycles: _buildCycles(worldstate)),
                if (worldstate.kuvaActive) KuvaCard(kuva: worldstate.kuva),
                TraderCard(trader: worldstate.voidTrader),
                SortieCard(sortie: worldstate.sortie)
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
