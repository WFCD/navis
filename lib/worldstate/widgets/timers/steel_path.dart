import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is WorldstateSuccess && n is WorldstateSuccess) {
      return p.worldstate.steelPath.expiry != n.worldstate.steelPath.expiry;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final steelPath = switch (state) {
            WorldstateSuccess() => state.worldstate.steelPath,
            _ => null,
          };

          final expiry = steelPath?.expiry ?? DateTime.now();

          return ListTile(
            leading: const AppIcon(WarframeSymbols.sp_logo, size: 30),
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath?.currentReward.name ?? ''),
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
