import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: (p, n) {
          if (p is SolState && n is SolState) {
            return p.worldstate.steelPath.expiry !=
                n.worldstate.steelPath.expiry;
          }
          return false;
        },
        builder: (context, state) {
          final steelPath = (state as SolState).worldstate.steelPath;

          return ListTile(
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath.currentReward.name),
            trailing: CountdownTimer(
              tooltip: context.l10n.countdownTooltip(steelPath.expiry!),
              expiry: steelPath.expiry!,
            ),
          );
        },
      ),
    );
  }
}
