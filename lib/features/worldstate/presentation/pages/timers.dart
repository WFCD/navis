import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../utils/faction_utils.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/common/refresh_indicator_bloc_screen.dart';
import '../widgets/timers/timers.dart';

class Timers extends StatelessWidget {
  const Timers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (BuildContext context, SolsystemState state) {
        if (state is SolState) {
          return MobileTimers(state);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

List<CycleEntry> _buildCycles(
    NavisLocalizations locale, Worldstate worldstate) {
  const size = 28.0;

  const solCycle = <Icon>[
    Icon(Icons.brightness_7, color: Colors.amber, size: size),
    Icon(Icons.brightness_3, color: Colors.blue, size: size)
  ];

  const tempCycle = <Icon>[
    Icon(NavisSysIcons.heat_wave, color: Colors.red, size: size),
    Icon(Icons.ac_unit, color: Colors.blue, size: size)
  ];

  final cambionCycle = <Widget>[
    StaticBox.text(text: 'Fass'),
    StaticBox.text(text: 'Vome')
  ];

  return <CycleEntry>[
    CycleEntry(
      name: locale.earthCycleTitle,
      states: solCycle,
      cycle: worldstate.earthCycle,
    ),
    CycleEntry(
      name: locale.cetusCycleTitle,
      states: solCycle,
      cycle: worldstate.cetusCycle,
    ),
    CycleEntry(
      name: locale.vallisCycleTitle,
      states: tempCycle,
      cycle: worldstate.vallisCycle,
    ),
    CycleEntry(
      name: locale.cambionCycleTitle,
      states: cambionCycle,
      cycle: worldstate.cetusCycle,
    )
  ];
}

List<Progress> _buildProgress(
    NavisLocalizations locale, Worldstate worldstate) {
  return <Progress>[
    Progress(
      name: locale.formorianTitle,
      color: factionColor('Grineer'),
      progress: double.parse(worldstate.constructionProgress.fomorianProgress),
    ),
    Progress(
      name: locale.razorbackTitle,
      color: factionColor('Corpus'),
      progress: double.parse(worldstate.constructionProgress.razorbackProgress),
    )
  ];
}

class MobileTimers extends StatelessWidget {
  const MobileTimers(this.state);

  final SolState state;

  Worldstate get _worldstate => state.worldstate;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('mobile_timers'),
      cacheExtent: 1000,
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const DailyReward(),
            ConstructionProgressCard(
              constructionProgress: _buildProgress(context.locale, _worldstate),
            ),
            if (state.eventsActive) EventCard(events: _worldstate.events),
            if (state.activeAcolytes)
              AcolyteCard(enemies: _worldstate.persistentEnemies),
            if (state.arbitrationActive)
              ArbitrationCard(arbitration: _worldstate.arbitration),
            if (state.activeAlerts) AlertsCard(alerts: _worldstate.alerts),
            if (state.outpostDetected)
              SentientOutpostCard(outpost: _worldstate.sentientOutposts),
            CycleCard(cycles: _buildCycles(context.locale, _worldstate)),
            if (state.activeSiphons) KuvaCard(kuva: _worldstate.kuva),
            TraderCard(trader: _worldstate.voidTrader),
            if (state.activeSales) DarvoDealCard(deals: _worldstate.dailyDeals),
            SortieCard(sortie: _worldstate.sortie)
          ]),
        )
      ],
    );
  }
}
