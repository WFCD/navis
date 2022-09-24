import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class ArchonHuntCard extends StatelessWidget {
  const ArchonHuntCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) =>
          (p as SolState).worldstate.sortie.expiry !=
          (n as SolState).worldstate.sortie.expiry,
      builder: (context, state) {
        final archonHunt = (state as SolState).worldstate.archonHunt;

        // Will default to DateTime.now() under the hood.
        // ignore: avoid-non-null-assertion
        final expiry = archonHunt.expiry!;

        return Sortie(
          faction: archonHunt.factionKey ?? archonHunt.faction,
          boss: archonHunt.boss,
          missions: archonHunt.missions,
          timer: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
          ),
        );
      },
    );
  }
}
