import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';

class SentientOutpostCard extends StatelessWidget {
  const SentientOutpostCard({super.key});

  bool _buildWhen(WorldState previous, WorldState next) {
    final previousOutpost = switch (previous) {
      WorldstateSuccess() => previous.seed.sentientOutposts,
      _ => null,
    };

    final nextOutpost = switch (next) {
      WorldstateSuccess() => next.seed.sentientOutposts,
      _ => null,
    };

    return previousOutpost?.mission?.node != nextOutpost?.mission?.node;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final outpost = switch (state) {
            WorldstateSuccess() => state.seed.sentientOutposts,
            _ => null,
          };

          final mission = outpost?.mission;
          final expiry = outpost?.expiry ?? DateTime.now();

          return ListTile(
            leading: const Icon(WarframeSymbols.factions_sentient, size: 40),
            title: Text(mission?.node ?? ''),
            subtitle: Text('${mission?.faction ?? ''} | ${mission?.type ?? ''}'),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
