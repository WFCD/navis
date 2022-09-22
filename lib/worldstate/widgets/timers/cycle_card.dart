import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

class CycleCard extends StatelessWidget {
  const CycleCard({super.key});

  List<CycleEntry> _buildCycles(
    NavisLocalizations locale,
    Worldstate worldstate,
  ) {
    const size = 28.0;

    const solCycle = <Icon>[
      Icon(Icons.brightness_7, color: Colors.amber, size: size),
      Icon(Icons.brightness_3, color: Colors.blue, size: size),
    ];

    const tempCycle = <Icon>[
      Icon(Icons.sunny, color: Colors.red, size: size),
      Icon(Icons.ac_unit, color: Colors.blue, size: size),
    ];

    final cambionCycle = <Widget>[
      ColoredContainer.text(text: 'Fass'),
      ColoredContainer.text(text: 'Vome'),
    ];

    final zarimanCycle = <Widget>[
      const FactionIcon(name: 'Corpus'),
      const FactionIcon(name: 'Grineer'),
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
      ),
      CycleEntry(
        name: locale.zarimanCycleTitle,
        cycle: worldstate.zarimanCycle,
        states: zarimanCycle,
      ),
    ];
  }

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    if (previous is SolState && next is SolState) {
      final p = previous;
      final n = next;

      return p.worldstate.earthCycle.expiry != n.worldstate.earthCycle.expiry ||
          p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry ||
          p.worldstate.vallisCycle.expiry != n.worldstate.vallisCycle.expiry;
    }

    if (next is SystemError) {
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final cycles =
            _buildCycles(context.l10n, (state as SolState).worldstate);

        return AppCard(
          child: Column(
            children: <Widget>[
              for (final cycle in cycles) _CycleWidget(entry: cycle),
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

class _CycleWidget extends StatelessWidget {
  const _CycleWidget({required this.entry});

  final CycleEntry entry;

  @override
  Widget build(BuildContext context) {
    // Will default to DateTime.now() under the hood.
    // ignore: avoid-non-null-assertion
    final expiry = entry.cycle.expiry!;

    return ListTile(
      key: ValueKey(entry.name),
      title: Text(
        entry.name,
        style:
            context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (entry.cycle.getStateBool) entry.states.first else entry.states[1],
          SizedBoxSpacer.spacerWidth6,
          CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
          ),
        ],
      ),
    );
  }
}
