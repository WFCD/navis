import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/feed_cards.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/outpost_card.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class Timers extends StatelessWidget {
  const Timers({Key key}) : super(key: key);

  List<CycleEntry> _buildCycles(
      NavisLocalizations localizations, Worldstate worldstate) {
    const size = 28.0;

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

            return ListView(
              cacheExtent: 500.0 * 2,
              children: <Widget>[
                if (state.eventsActive) EventCard(events: worldstate.events),
                if (state.activeAcolytes)
                  AcolyteCard(enemies: worldstate.persistentEnemies),
                ConstructionProgressCard(
                  constructionProgress:
                      _buildProgress(localizations, worldstate),
                ),
                if (state.arbitrationActive)
                  ArbitrationCard(arbitration: worldstate.arbitration),
                if (state.activeAlerts) AlertsCard(alerts: worldstate.alerts),
                if (state.outpostDetected)
                  SentientOutpostCard(outpost: worldstate.sentientOutposts),
                CycleCard(cycles: _buildCycles(localizations, worldstate)),
                if (state.activeSiphons) KuvaCard(kuva: worldstate.kuva),
                TraderCard(trader: worldstate.voidTrader),
                if (state.activeSales)
                  DarvoDealCard(
                    deals: worldstate.dailyDeals,
                    items: state.dealInfo,
                  ),
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
