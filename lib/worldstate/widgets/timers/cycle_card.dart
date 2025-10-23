import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:worldstate_models/worldstate_models.dart';

class CycleCard extends StatelessWidget {
  const CycleCard({super.key});

  static const double _iconSize = 28;

  Widget _stateChange<T extends Enum>(T state) {
    return switch (state) {
      CetusState.day => const Icon(Icons.brightness_7, color: Colors.amber, size: _iconSize),
      CetusState.night => const Icon(Icons.brightness_3, color: Colors.blue, size: _iconSize),
      VallisState.cold => const Icon(Icons.ac_unit, color: Colors.blue, size: _iconSize),
      VallisState.warm => const Icon(Icons.sunny, color: Colors.red, size: _iconSize),
      CambionState.vome => _shadowIcon(state.name, WarframeIcons.requiemVome, Colors.blueAccent),
      CambionState.fass => _shadowIcon(state.name, WarframeIcons.requiemFass, Colors.red),
      ZarimanState() => FactionIcon(name: state.name, size: _iconSize),
      Enum() => const Icon(WarframeIcons.nightmare, color: Colors.white, size: _iconSize),
    };
  }

  Widget _shadowIcon(String tooltip, IconData icon, Color color) {
    const scaleUp = 15;
    final shadows = <Shadow>[Shadow(color: color, blurRadius: 5)];

    return Tooltip(
      message: toBeginningOfSentenceCase(tooltip),
      child: Icon(icon, color: Colors.red, size: _iconSize + scaleUp, shadows: shadows),
    );
  }

  Widget _stateText<T extends Enum>(BuildContext context, T state) {
    final locale = context.l10n;
    final text = switch (state) {
      DuviriState.joy => locale.duviriJoy,
      DuviriState.anger => locale.duviriAnger,
      DuviriState.envy => locale.duviriEnvy,
      DuviriState.sorrow => locale.duviriSorrow,
      DuviriState.fear => locale.duviriFear,
      Enum() => state.name,
    };

    return ColoredContainer.text(text: toBeginningOfSentenceCase(text)!, style: Theme.of(context).textTheme.labelLarge);
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (previous is WorldstateSuccess && next is WorldstateSuccess) {
      final p = previous;
      final n = next;

      return p.seed.cetusCycle.expiry != n.seed.cetusCycle.expiry ||
          p.seed.vallisCycle.expiry != n.seed.vallisCycle.expiry ||
          n.seed.zarimanCycle != n.seed.zarimanCycle;
    }

    if (next is WorldstateFailure) {
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final locale = context.l10n;
          final worldstate = switch (state) {
            WorldstateSuccess() => state.seed,
            _ => null,
          };

          final cetusCycle = worldstate?.cetusCycle;
          final vallisCycle = worldstate?.vallisCycle;
          final cambionCycle = worldstate?.cambionCycle;
          final zarimanCycle = worldstate?.zarimanCycle;
          final duviriCycle = worldstate?.duviriCycle;
          // final midrathCycle = midrathExpiry();

          return Column(
            children: <Widget>[
              _CycleRow(
                currentState: _stateChange(cetusCycle?.state ?? CetusState.day),
                name: locale.cetusCycleTitle,
                expiry: cetusCycle?.expiry,
              ),
              _CycleRow(
                currentState: _stateChange(vallisCycle?.state ?? VallisState.warm),
                name: locale.vallisCycleTitle,
                expiry: vallisCycle?.expiry,
              ),
              _CycleRow(
                currentState: _stateChange(cambionCycle?.state ?? CambionState.fass),
                name: locale.cambionCycleTitle,
                expiry: cambionCycle?.expiry,
              ),
              _CycleRow(
                currentState: _stateChange(zarimanCycle?.state ?? ZarimanState.corpus),
                name: locale.zarimanCycleTitle,
                expiry: zarimanCycle?.expiry,
              ),
              _CycleRow(
                name: locale.duviriCycleTitle,
                expiry: duviriCycle?.expiry,
                currentState: _stateText(context, duviriCycle?.state ?? DuviriState.envy),
              ),
              // _CycleRow(currentState: _stateChange(midrathCycle.state), name: 'Midrath', expiry: midrathCycle.expiry),
            ],
          );
        },
      ),
    );
  }
}

class _CycleRow extends StatelessWidget {
  const _CycleRow({required this.currentState, required this.name, required this.expiry});

  final Widget currentState;
  final String name;
  final DateTime? expiry;

  @override
  Widget build(BuildContext context) {
    final expiry = this.expiry ?? DateTime.timestamp();

    return ListTile(
      title: Text(name, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          currentState,
          Gaps.gap6,
          CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
        ],
      ),
    );
  }
}
