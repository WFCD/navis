import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SentientOutpostCard extends StatelessWidget {
  const SentientOutpostCard({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is SolState && n is SolState) {
      return p.worldstate.sentientOutposts.expiry !=
          n.worldstate.sentientOutposts.expiry;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final outpost = (state as SolState).worldstate.sentientOutposts;
          final mission = outpost.mission;

          // Will default to DateTime.now() under the hood.
          // ignore: avoid-non-null-assertion
          final expiry = outpost.expiry!;

          return ListTile(
            leading: const Icon(GenesisAssets.sentient, size: 40),
            title: Text(mission?.node ?? ''),
            subtitle: Text('${mission?.faction} | ${mission?.type}'),
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
