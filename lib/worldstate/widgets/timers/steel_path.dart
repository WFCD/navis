import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is SolState && n is SolState) {
      return p.worldstate.steelPath.expiry != n.worldstate.steelPath.expiry;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final steelPath = (state as SolState).worldstate.steelPath;

          // Will default to DateTime.now() under the hood.
          // ignore: avoid-non-null-assertion
          final expiry = steelPath.expiry!;

          return ListTile(
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath.currentReward.name),
            trailing: CountdownTimer(
              tooltip: context.l10n.countdownTooltip(expiry),
              expiry: expiry,
            ),
          );
        },
      ),
    );
  }
}
