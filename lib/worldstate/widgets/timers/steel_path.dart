import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<WorldstateCubit, SolsystemState, SteelPath?>(
        selector: (s) => switch (s) {
          WorldstateSuccess() => s.worldstate.steelPath,
          _ => null,
        },
        builder: (context, steelPath) {
          final expiry = steelPath?.expiry ?? DateTime.timestamp();

          return ListTile(
            leading: const AppIcon(WarframeSymbols.sp_logo, size: 30),
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath?.currentReward.name ?? ''),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
