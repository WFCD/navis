import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../injection_container.dart';
import '../../../../l10n/l10n.dart';
import '../../utils/faction_utils.dart';
import '../bloc/darvodeal_bloc.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/timers/timers.dart';

class Timers extends TraceableStatelessWidget {
  const Timers({Key? key, required this.state}) : super(key: key);

  final SolState state;

  @override
  Widget build(BuildContext context) {
    return MobileTimers(state);
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
    Icon(NavisSysIcons.heatWave, color: Colors.red, size: size),
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
      percentage:
          double.parse(worldstate.constructionProgress.fomorianProgress),
    ),
    Progress(
      name: locale.razorbackTitle,
      color: factionColor('Corpus'),
      percentage:
          double.parse(worldstate.constructionProgress.razorbackProgress),
    )
  ];
}

class MobileTimers extends StatelessWidget {
  const MobileTimers(this.state);

  final SolState state;

  Worldstate get _worldstate => state.worldstate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DailyReward(),
        ConstructionProgressCard(
          constructionProgress: _buildProgress(context.l10n, _worldstate),
        ),
        if (state.eventsActive) EventCard(events: _worldstate.events),
        if (state.activeAcolytes)
          AcolyteCard(enemies: _worldstate.persistentEnemies!),
        if (state.arbitrationActive)
          ArbitrationCard(arbitration: _worldstate.arbitration!),
        if (state.outpostDetected)
          SentientOutpostCard(outpost: _worldstate.sentientOutposts),
        SteelPathCard(steelPath: _worldstate.steelPath),
        if (state.activeAlerts) AlertsCard(alerts: _worldstate.alerts),
        CycleCard(cycles: _buildCycles(context.l10n, _worldstate)),
        TraderCard(trader: _worldstate.voidTrader),
        if (state.activeSales)
          BlocProvider(
            create: (context) => sl<DarvodealBloc>(),
            child: DarvoDealCard(deals: _worldstate.dailyDeals),
          ),
        SortieCard(sortie: _worldstate.sortie)
      ],
    );
  }
}
