import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Sortie;

class ArchonHuntCard extends StatelessWidget {
  const ArchonHuntCard({super.key});

  bool _buildWhen(WorldState previous, WorldState next) {
    final previousArchonHunt = switch (previous) {
      WorldstateSuccess() => previous.seed.archonHunt,
      _ => null,
    };

    final nextArchonHunt = switch (next) {
      WorldstateSuccess() => next.seed.archonHunt,
      _ => null,
    };

    return previousArchonHunt?.expiry != nextArchonHunt?.expiry;
  }

  SortieMission toSortieMission(Mission mission) {
    return SortieMission(node: mission.node, objective: mission.type, modifier: mission.exclusiveWeapon);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final archonHunt = switch (state) {
          WorldstateSuccess() => state.seed.archonHunt,
          _ => null,
        };

        final missions = archonHunt?.missions ?? [];
        final expiry = archonHunt?.expiry ?? DateTime.now();

        return SortieWidget(
          faction: archonHunt?.factionKey ?? '',
          boss: archonHunt?.boss ?? '',
          missions: missions.map(toSortieMission).toList(),
          timer: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
        );
      },
    );
  }
}
