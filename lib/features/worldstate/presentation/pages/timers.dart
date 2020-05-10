import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/entities.dart';

import '../../../../core/widgets/widgets.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/timers/timers.dart';

class Timers extends StatelessWidget {
  const Timers({Key key}) : super(key: key);

  List<CycleEntry> _buildCycles(
      NavisLocalizations localizations, Worldstate worldstate) {
    const size = 28.0;

    const solCycle = <Icon>[
      Icon(NavisSysIcons.sun, color: Colors.amber, size: size),
      Icon(NavisSysIcons.moon, color: Colors.blue, size: size)
    ];

    const tempCycle = <Icon>[
      Icon(NavisSysIcons.waves, color: Colors.red, size: size),
      Icon(NavisSysIcons.snow, color: Colors.blue, size: size)
    ];

    return <CycleEntry>[
      CycleEntry(
        name: localizations.earthCycleTitle,
        states: solCycle,
        cycle: worldstate.earthCycle,
      ),
      CycleEntry(
        name: localizations.cetusCycleTitle,
        states: solCycle,
        cycle: worldstate.cetusCycle,
      ),
      CycleEntry(
        name: localizations.vallisCycleTitle,
        states: tempCycle,
        cycle: worldstate.vallisCycle,
      )
    ];
  }

  List<Progress> _buildProgress(
      NavisLocalizations localizations, Worldstate worldstate) {
    return <Progress>[
      Progress(
        name: localizations.formorianTitle,
        color: factionColor('Grineer'),
        progress:
            double.parse(worldstate.constructionProgress.fomorianProgress),
      ),
      Progress(
        name: localizations.razorbackTitle,
        color: factionColor('Corpus'),
        progress:
            double.parse(worldstate.constructionProgress.razorbackProgress),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return RefreshIndicator(
      onRefresh: context.bloc<SolsystemBloc>().update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            final worldstate = state.worldstate;

            if (MediaQuery
                .of(context)
                .size
                .width > 600) {
              return StaggeredGridView.count(
                crossAxisCount: 75,
                staggeredTiles: const <StaggeredTile>[
                  StaggeredTile.fit(40),
                  StaggeredTile.fit(35),
                  StaggeredTile.fit(40),
                  // Acolytes
                  StaggeredTile.fit(35),
                  StaggeredTile.fit(40),
                  StaggeredTile.fit(35),
                  StaggeredTile.fit(35),
                  // Kuva Siphon
                  StaggeredTile.fit(40),
                  StaggeredTile.fit(35),
                  StaggeredTile.fit(40)
                ],
                children: <Widget>[
                  const DailyReward(),
                  ConstructionProgressCard(
                    constructionProgress:
                    _buildProgress(localizations, worldstate),
                  ),
                  if (state.eventsActive)
                    EventCard(events: worldstate.events),
                  // if (state.activeAcolytes)
                  //   AcolyteCard(enemies: worldstate.persistentEnemies),
                  if (state.arbitrationActive)
                    ArbitrationCard(arbitration: worldstate.arbitration),
                  if (state.activeAlerts)
                    AlertsCard(alerts: worldstate.alerts),
                  if (state.outpostDetected)
                    SentientOutpostCard(outpost: worldstate.sentientOutposts),
                  CycleCard(cycles: _buildCycles(localizations, worldstate)),
                  // if (state.activeSiphons) KuvaCard(kuva: worldstate.kuva),
                  TraderCard(trader: worldstate.voidTrader),
                  if (state.activeSales)
                    DarvoDealCard(deals: worldstate.dailyDeals),
                  SortieCard(sortie: worldstate.sortie)
                ],
              );
            }

            return ListView(
              cacheExtent: 1000,
              children: <Widget>[
                const DailyReward(),
                ConstructionProgressCard(
                  constructionProgress:
                  _buildProgress(localizations, worldstate),
                ),
                if (state.eventsActive) EventCard(events: worldstate.events),
                if (state.activeAcolytes)
                  AcolyteCard(enemies: worldstate.persistentEnemies),
                if (state.arbitrationActive)
                  ArbitrationCard(arbitration: worldstate.arbitration),
                if (state.activeAlerts) AlertsCard(alerts: worldstate.alerts),
                if (state.outpostDetected)
                  SentientOutpostCard(outpost: worldstate.sentientOutposts),
                CycleCard(cycles: _buildCycles(localizations, worldstate)),
                if (state.activeSiphons) KuvaCard(kuva: worldstate.kuva),
                TraderCard(trader: worldstate.voidTrader),
                if (state.activeSales)
                  DarvoDealCard(deals: worldstate.dailyDeals),
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
