import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) =>
          (p as SolState).worldstate.sortie.expiry !=
          (n as SolState).worldstate.sortie.expiry,
      builder: (context, state) {
        final sortie = (state as SolState).worldstate.sortie;

        // Will default to DateTime.now() under the hood.
        // ignore: avoid-non-null-assertion
        final expiry = sortie.expiry!;

        return Sortie(
          faction: sortie.factionKey ?? sortie.faction,
          boss: sortie.boss,
          variants: sortie.variants,
          timer: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
          ),
        );
      },
    );
  }
}
