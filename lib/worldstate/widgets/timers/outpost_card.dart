import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';

class SentientOutpostCard extends StatelessWidget {
  const SentientOutpostCard({super.key});

  bool _buildWhen(WorldState previous, WorldState next) {
    final previousOutpost = switch (previous) {
      WorldstateSuccess() => previous.seed.sentientOutpost,
      _ => null,
    };

    final nextOutpost = switch (next) {
      WorldstateSuccess() => next.seed.sentientOutpost,
      _ => null,
    };

    return previousOutpost?.node != nextOutpost?.node;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final outpost = switch (state) {
            WorldstateSuccess() => state.seed.sentientOutpost,
            _ => null,
          };

          final mission = outpost?.node;
          final expiry = outpost?.expiry ?? DateTime.now();

          return ListTile(
            leading: const Icon(WarframeIcons.factionsSentient, size: 40),
            title: Text(mission?.name ?? ''),
            subtitle: Text('${mission?.enemy ?? ''} | ${mission?.type ?? ''}'),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
