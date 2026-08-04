import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({super.key});

  SortieMission _toSortieMission(Variant mission) {
    // modifier is only null for archon hunt, safe to force for regular sorties
    return SortieMission(
      node: mission.node,
      objective: mission.type,
      modifier: mission.modifier!.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, Sortie?>(
      selector: (state) => switch (state) {
        WorldstateSuccess() => state.seed.sortie,
        _ => null,
      },
      builder: (context, sortie) {
        final missions = sortie?.missions ?? [];
        final expiry = sortie?.expiry ?? DateTime.now();

        return SortieWidget(
          key: GlobalKey(),
          faction: sortie?.factionKey ?? '',
          boss: sortie?.boss ?? '',
          missions: missions.map(_toSortieMission).toList(),
          timer: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
        );
      },
    );
  }
}
