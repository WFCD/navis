import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' as ws;

class DeepArchimedeaCard extends StatelessWidget {
  const DeepArchimedeaCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    final previousArchimedea = switch (previous) {
      WorldstateSuccess() => previous.worldstate.deepArchimedea,
      _ => null,
    };

    final currentArchimedea = switch (current) {
      WorldstateSuccess() => current.worldstate.deepArchimedea,
      _ => null,
    };

    return previousArchimedea?.id != currentArchimedea?.id;
  }

  @override
  Widget build(BuildContext context) {
    DateTime placeholder() => DateTime.timestamp().add(const Duration(days: 7));

    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final archimedea = switch (state) {
            WorldstateSuccess() => state.worldstate.deepArchimedea,
            _ => null
          };

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(context.l10n.archimedeaTitle),
                trailing: CountdownTimer(
                  tooltip: MaterialLocalizations.of(context)
                      .formatFullDate(archimedea?.expiry ?? placeholder()),
                  expiry: archimedea?.expiry ?? placeholder(),
                ),
              ),
              ListTile(
                title: Text(context.l10n.archimedeaWarningTitle),
                subtitle: Text(context.l10n.archimedeaWarningSubtitle),
                textColor: context.theme.colorScheme.onErrorContainer,
              ),
              MissionsCategory(missions: archimedea?.missions ?? []),
              PersonalModifierCategory(
                personalModifiers: archimedea?.personalModifiers ?? [],
              ),
            ],
          );
        },
      ),
    );
  }
}

class MissionsCategory extends StatelessWidget {
  const MissionsCategory({super.key, required this.missions});

  final List<ws.DeepArchimedeaMission> missions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        CategoryTitle(title: l10n.missionsCategoryTitle),
        ...missions.map(
          (pm) => ListTile(
            title: Text(pm.mission),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: pm.deviation.description,
                  child: Text(
                    '${l10n.archimedeaDeviationTitle}: ${pm.deviation.name}',
                  ),
                ),
                ...pm.riskVariables.map(
                  (rv) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Tooltip(
                      message: rv.description,
                      child: Text('${l10n.archimedeaRiskTitle}: ${rv.name}'),
                    ),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            dense: true,
          ),
        ),
      ],
    );
  }
}

class PersonalModifierCategory extends StatelessWidget {
  const PersonalModifierCategory({super.key, required this.personalModifiers});

  final List<ws.Modifier> personalModifiers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle(title: context.l10n.archimedeaPersonalModifierTitle),
        ...personalModifiers.map(
          (pm) => ListTile(
            title: Text(pm.name),
            subtitle: Text(pm.description),
            isThreeLine: true,
            dense: true,
          ),
        ),
      ],
    );
  }
}
