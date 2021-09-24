import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

import '../../../../../constants/sizedbox_spacer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../bloc/solsystem/solsystem_bloc.dart';

class CycleCard extends StatelessWidget {
  const CycleCard({Key? key}) : super(key: key);

  List<CycleEntry> _buildCycles(
    NavisLocalizations locale,
    Worldstate worldstate,
  ) {
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
        buildWhen: (p, n) =>
            p.worldstate.earthCycle.expiry != n.worldstate.earthCycle.expiry,
      ),
      CycleEntry(
        name: locale.cetusCycleTitle,
        states: solCycle,
        cycle: worldstate.cetusCycle,
        buildWhen: (p, n) =>
            p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry,
      ),
      CycleEntry(
        name: locale.vallisCycleTitle,
        states: tempCycle,
        cycle: worldstate.vallisCycle,
        buildWhen: (p, n) =>
            p.worldstate.vallisCycle.expiry != n.worldstate.vallisCycle.expiry,
      ),
      CycleEntry(
        name: locale.cambionCycleTitle,
        states: cambionCycle,
        cycle: worldstate.cetusCycle,
        buildWhen: (p, n) =>
            p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cycles = _buildCycles(
      NavisLocalizations.of(context)!,
      (BlocProvider.of<SolsystemBloc>(context).state as SolState).worldstate,
    );

    return CustomCard(
      child: Column(
        children: <Widget>[
          for (final cycle in cycles) CycleWidget(entry: cycle),
        ],
      ),
    );
  }
}

class CycleEntry {
  const CycleEntry({
    required this.states,
    required this.name,
    required this.cycle,
    required this.buildWhen,
  });

  final List<Widget> states;
  final String name;
  final CycleObject cycle;

  // We want to rebuild each one individually only when the timer actually
  // changes so we need an a buildWhen for each timer.
  final BlocBuilderCondition<SolState> buildWhen;
}

class CycleWidget extends StatelessWidget {
  const CycleWidget({Key? key, required this.entry}) : super(key: key);

  final CycleEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SolsystemBloc, SolsystemState>(
      buildWhen: (p, n) => entry.buildWhen(p as SolState, n as SolState),
      builder: (context, state) {
        return ListTile(
          title: Text(
            entry.name,
            style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (entry.cycle.getStateBool)
                entry.states[0]
              else
                entry.states[1],
              SizedBoxSpacer.spacerWidth6,
              CountdownTimer(expiry: entry.cycle.expiry!),
            ],
          ),
        );
      },
    );
  }
}
