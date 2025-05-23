import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

const double _iconSize = 28;

class CycleCard extends StatelessWidget {
  const CycleCard({super.key});

  Widget _earthStateIcon(EarthState state) {
    return switch (state) {
      EarthState.day => const Icon(Icons.brightness_7, color: Colors.amber, size: _iconSize),
      EarthState.night => const Icon(Icons.brightness_3, color: Colors.blue, size: _iconSize),
    };
  }

  Widget _vallisStateIcon(VallisState state) {
    return switch (state) {
      VallisState.cold => const Icon(Icons.ac_unit, color: Colors.blue, size: _iconSize),
      VallisState.warm => const Icon(Icons.sunny, color: Colors.red, size: _iconSize),
    };
  }

  Widget _cambionStateIcon(CambionState state) {
    const scaleUp = 15;
    final shadows = <Shadow>[
      Shadow(
        color: switch (state) {
          CambionState.vome => Colors.blueAccent,
          CambionState.fass => Colors.redAccent,
        },
        blurRadius: 5,
      ),
    ];

    return Tooltip(
      message: toBeginningOfSentenceCase(state.name),
      child: switch (state) {
        CambionState.vome => Icon(
          WarframeIcons.requiemVome,
          color: Colors.blue,
          size: _iconSize + scaleUp,
          shadows: shadows,
        ),
        CambionState.fass => Icon(
          WarframeIcons.requiemFass,
          color: Colors.red,
          size: _iconSize + scaleUp,
          shadows: shadows,
        ),
      },
    );
  }

  // Keep the function in case there's ever an icon for Fass and Vome.
  Widget _stateText(BuildContext context, String state) {
    return ColoredContainer.text(
      text: toBeginningOfSentenceCase(state)!,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (previous is WorldstateSuccess && next is WorldstateSuccess) {
      final p = previous;
      final n = next;

      return p.seed.earthCycle.expiry != n.seed.earthCycle.expiry ||
          p.seed.cetusCycle.expiry != n.seed.cetusCycle.expiry ||
          p.seed.vallisCycle.expiry != n.seed.vallisCycle.expiry;
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

          return Column(
            children: <Widget>[
              _CycleRow(
                currentState: _earthStateIcon(cetusCycle?.state ?? EarthState.day),
                name: locale.cetusCycleTitle,
                expiry: cetusCycle?.expiry,
              ),
              _CycleRow(
                currentState: _vallisStateIcon(vallisCycle?.state ?? VallisState.warm),
                name: locale.vallisCycleTitle,
                expiry: vallisCycle?.expiry,
              ),
              _CycleRow(
                currentState: _cambionStateIcon(cambionCycle?.state ?? CambionState.fass),
                name: locale.cambionCycleTitle,
                expiry: cambionCycle?.expiry,
              ),
              _CycleRow(
                currentState: FactionIcon(name: zarimanCycle?.state.name ?? ZarimanState.corpus.name, size: _iconSize),
                name: locale.zarimanCycleTitle,
                expiry: zarimanCycle?.expiry,
              ),
              _CycleRow(
                name: locale.duviriCycleTitle,
                expiry: duviriCycle?.expiry,
                currentState: _stateText(context, switch (duviriCycle?.state ?? DuviriState.envy) {
                  DuviriState.joy => locale.duviriJoy,
                  DuviriState.anger => locale.duviriAnger,
                  DuviriState.envy => locale.duviriEnvy,
                  DuviriState.sorrow => locale.duviriSorrow,
                  DuviriState.fear => locale.duviriFear,
                  // ignore: require_trailing_commas The Formatter keeps removing it lol
                }),
              ),
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
    final expiry = this.expiry ?? DateTime.now();

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
