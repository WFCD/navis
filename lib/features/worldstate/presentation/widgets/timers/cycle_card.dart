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

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final p = previous as SolState;
    final n = next as SolState;

    return p.worldstate.earthCycle.expiry != n.worldstate.earthCycle.expiry ||
        p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry ||
        p.worldstate.vallisCycle.expiry != n.worldstate.vallisCycle.expiry ||
        p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemBloc, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final cycles = _buildCycles(
          NavisLocalizations.of(context)!,
          (state as SolState).worldstate,
        );

        return CustomCard(
          child: Column(
            children: <Widget>[
              for (final cycle in cycles) CycleWidget(entry: cycle),
            ],
          ),
        );
      },
    );
  }
}

class CycleEntry {
  const CycleEntry({
    required this.states,
    required this.name,
    required this.cycle,
  });

  final List<Widget> states;
  final String name;
  final CycleObject cycle;
}

class CycleWidget extends StatelessWidget {
  const CycleWidget({Key? key, required this.entry}) : super(key: key);

  final CycleEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      key: ValueKey(entry.name),
      title: Text(
        entry.name,
        style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (entry.cycle.getStateBool) entry.states[0] else entry.states[1],
          SizedBoxSpacer.spacerWidth6,
          CountdownTimer(expiry: entry.cycle.expiry!),
        ],
      ),
    );
  }
}
