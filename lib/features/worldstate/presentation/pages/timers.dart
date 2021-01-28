import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../injection_container.dart';
import '../../utils/faction_utils.dart';
import '../bloc/darvodeal_bloc.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/timers/timers.dart';

class Timers extends StatelessWidget {
  const Timers({Key key, @required this.state})
      : assert(state != null),
        super(key: key);

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
    return ListView(
      children: [
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
