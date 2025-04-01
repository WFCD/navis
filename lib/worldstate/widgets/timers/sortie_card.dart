import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({super.key});

  bool _buildWhen(WorldState previous, WorldState next) {
    final previousSortie = switch (previous) {
      WorldstateSuccess() => previous.seed.sortie,
      _ => null,
    };

    final nextSortie = switch (next) {
      WorldstateSuccess() => next.seed.sortie,
      _ => null,
    };

    return previousSortie?.expiry != nextSortie?.expiry;
  }

  SortieMission toSortieMission(Variant mission) {
    return SortieMission(node: mission.node, objective: mission.missionType, modifier: mission.modifier);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final sortie = switch (state) {
          WorldstateSuccess() => state.seed.sortie,
          _ => null,
        };

        final missions = sortie?.variants ?? [];
        final expiry = sortie?.expiry ?? DateTime.now();

        return SortieWidget(
          key: GlobalKey(),
          faction: sortie?.factionKey ?? sortie?.faction ?? '',
          boss: sortie?.boss ?? '',
          missions: missions.map(toSortieMission).toList(),
          timer: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
        );
      },
    );
  }
}
