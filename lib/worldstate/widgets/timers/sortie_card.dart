import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' show Variant;

class SortieCard extends StatelessWidget {
  const SortieCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final previousSortie = switch (previous) {
      SolState() => previous.worldstate.sortie,
      _ => null,
    };

    final nextSortie = switch (next) {
      SolState() => next.worldstate.sortie,
      _ => null,
    };

    return previousSortie?.expiry != nextSortie?.expiry;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final sortie = switch (state) {
          SolState() => state.worldstate.sortie,
          _ => null,
        };

        final expiry = sortie?.expiry ?? DateTime.now();

        return Sortie(
          faction: sortie?.factionKey ?? sortie?.faction ?? '',
          boss: sortie?.boss ?? '',
          variants: sortie?.variants ?? <Variant>[],
          timer: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
          ),
        );
      },
    );
  }
}
