import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class ArchonHuntCard extends StatelessWidget {
  const ArchonHuntCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final previousArchonHunt = switch (previous) {
      SolState() => previous.worldstate.archonHunt,
      _ => null,
    };

    final nextArchonHunt = switch (next) {
      SolState() => next.worldstate.archonHunt,
      _ => null,
    };

    return previousArchonHunt?.expiry != nextArchonHunt?.expiry;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final archonHunt = switch (state) {
          SolState() => state.worldstate.archonHunt,
          _ => null,
        };

        final expiry = archonHunt?.expiry ?? DateTime.now();

        return Sortie(
          faction: archonHunt?.factionKey ?? archonHunt?.faction ?? '',
          boss: archonHunt?.boss ?? '',
          missions: archonHunt?.missions,
          timer: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
          ),
        );
      },
    );
  }
}
