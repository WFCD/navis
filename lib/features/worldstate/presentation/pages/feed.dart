import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/feed_cards.dart';
import 'package:navis/features/worldstate/presentation/widgets/feed/outpost_card.dart';
import 'package:navis/l10n/localizations.dart';
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
        name: NavisLocalizations.current.earthCycleTitle,
        states: solCycle,
        cycle: worldstate.earthCycle,
      ),
      CycleEntry(
        name: NavisLocalizations.current.cetusCycleTitle,
        states: solCycle,
        cycle: worldstate.cetusCycle,
      ),
      CycleEntry(
        name: NavisLocalizations.current.vallisCycleTitle,
        states: tempCycle,
        cycle: worldstate.vallisCycle,
      )
    ];
  }

  List<Progress> _buildProgress(Worldstate worldstate) {
    return <Progress>[
      Progress(
        name: NavisLocalizations.current.formorianTitle,
        color: factionColor('Grineer'),
        progress:
            double.parse(worldstate.constructionProgress.fomorianProgress),
      ),
      Progress(
        name: NavisLocalizations.current.razorbackTitle,
        color: factionColor('Corpus'),
        progress:
            double.parse(worldstate.constructionProgress.razorbackProgress),
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
                if (state.eventsActive) EventCard(events: worldstate.events),
                if (state.activeAcolytes)
                  AcolyteCard(enemies: worldstate.persistentEnemies),
                ConstructionProgressCard(
                  constructionProgress: _buildProgress(worldstate),
                ),
                if (state.arbitrationActive)
                  ArbitrationCard(arbitration: worldstate.arbitration),
                if (state.activeAlerts) AlertsCard(alerts: worldstate.alerts),
                if (state.outpostDetected)
                  SentientOutpostCard(outpost: worldstate.sentientOutposts),
                CycleCard(cycles: _buildCycles(worldstate)),
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
