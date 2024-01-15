import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

const double _iconSize = 28;

class CycleCard extends StatelessWidget {
  const CycleCard({super.key});

  Widget _earthStateIcon(EarthState state) {
    return switch (state) {
      EarthState.day =>
        const Icon(Icons.brightness_7, color: Colors.amber, size: _iconSize),
      EarthState.night =>
        const Icon(Icons.brightness_3, color: Colors.blue, size: _iconSize),
    };
  }

  Widget _vallisStateIcon(VallisState state) {
    return switch (state) {
      VallisState.cold =>
        const Icon(Icons.ac_unit, color: Colors.blue, size: _iconSize),
      VallisState.warm =>
        const Icon(Icons.sunny, color: Colors.red, size: _iconSize),
    };
  }

  // Keep the function in case there's ever an icon for Fass and Vome.
  Widget _cambionStateIcon(CambionState state) {
    return ColoredContainer.text(text: toBeginningOfSentenceCase(state.name)!);
  }

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    if (previous is WorldstateSuccess && next is WorldstateSuccess) {
      final p = previous;
      final n = next;

      return p.worldstate.earthCycle.expiry != n.worldstate.earthCycle.expiry ||
          p.worldstate.cetusCycle.expiry != n.worldstate.cetusCycle.expiry ||
          p.worldstate.vallisCycle.expiry != n.worldstate.vallisCycle.expiry;
    }

    if (next is WorldstateFailure) {
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final locale = context.l10n;
        final worldstate = switch (state) {
          WorldstateSuccess() => state.worldstate,
          _ => null,
        };

        final earthCycle = worldstate?.earthCycle;
        final cetusCycle = worldstate?.cetusCycle;
        final vallisCycle = worldstate?.vallisCycle;
        final cambionCycle = worldstate?.cambionCycle;
        final zarimanCycle = worldstate?.zarimanCycle;
        final duviriCycle = worldstate?.duviriCycle;

        return AppCard(
          child: Column(
            children: <Widget>[
              _CycleRow(
                currentState:
                    _earthStateIcon(earthCycle?.state ?? EarthState.day),
                name: locale.earthCycleTitle,
                expiry: earthCycle?.expiry,
              ),
              _CycleRow(
                currentState:
                    _earthStateIcon(cetusCycle?.state ?? EarthState.day),
                name: locale.cetusCycleTitle,
                expiry: cetusCycle?.expiry,
              ),
              _CycleRow(
                currentState:
                    _vallisStateIcon(vallisCycle?.state ?? VallisState.warm),
                name: locale.vallisCycleTitle,
                expiry: vallisCycle?.expiry,
              ),
              _CycleRow(
                currentState:
                    _cambionStateIcon(cambionCycle?.state ?? CambionState.fass),
                name: locale.cambionCycleTitle,
                expiry: cambionCycle?.expiry,
              ),
              _CycleRow(
                currentState: FactionIcon(
                  name: zarimanCycle?.state.name ?? ZarimanState.corpus.name,
                  iconSize: _iconSize,
                ),
                name: locale.zarimanCycleTitle,
                expiry: zarimanCycle?.expiry,
              ),
              _CycleRow(
                currentState: ColoredContainer.text(
                  text: toBeginningOfSentenceCase(
                    duviriCycle?.state.name ?? DuviriState.anger.name,
                  )!,
                ),
                name: 'Duviri Cycle',
                expiry: duviriCycle?.expiry,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CycleRow extends StatelessWidget {
  const _CycleRow({
    required this.currentState,
    required this.name,
    required this.expiry,
  });

  final Widget currentState;
  final String name;
  final DateTime? expiry;

  @override
  Widget build(BuildContext context) {
    final expiry = this.expiry ?? DateTime.now();

    return ListTile(
      title: Text(
        name,
        style: context.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          currentState,
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
