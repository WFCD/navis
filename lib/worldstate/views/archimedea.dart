import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/reset_timers.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ArchimedeaPage extends StatelessWidget {
  const ArchimedeaPage({super.key, required this.archimedea});

  final Archimedea archimedea;

  @override
  Widget build(BuildContext context) {
    final reset = weeklReset();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text('${context.l10n.archimedeaResetTitle}:'),
            trailing: CountdownTimer(tooltip: MaterialLocalizations.of(context).formatFullDate(reset), expiry: reset),
          ),
          _ArchimedeaMissionsCategory(missions: archimedea.missions),
          _PersonalModifierCategory(personalModifiers: archimedea.personalModifiers),
          const Divider(),
          ListTile(
            title: Text(context.l10n.archimedeaWarningTitle),
            subtitle: Text(context.l10n.archimedeaWarningSubtitle),
            textColor: context.theme.colorScheme.onErrorContainer,
          ),
        ],
      ),
    );
  }
}

class _ArchimedeaMissionsCategory extends StatelessWidget {
  const _ArchimedeaMissionsCategory({required this.missions});

  final List<ArchimedeaMission> missions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final secondary = context.theme.colorScheme.secondary;
    final titleStyle = context.textTheme.titleSmall;

    return Column(
      children: [
        ...missions.map(
          (m) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(m.mission, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: secondary)),
              ),
              ListTile(
                title: Text('${l10n.archimedeaDeviationTitle}: ${m.deviation.name}', style: titleStyle),
                subtitle: Text(m.deviation.description),
              ),
              ...m.riskVariables.map(
                (rv) => ListTile(
                  title: Text('${l10n.archimedeaRiskTitle}: ${rv.name}', style: titleStyle),
                  subtitle: Text(rv.description),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PersonalModifierCategory extends StatelessWidget {
  const _PersonalModifierCategory({required this.personalModifiers});

  final List<Modifier> personalModifiers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle(title: context.l10n.archimedeaPersonalModifierTitle),
        ...personalModifiers.map((pm) => ListTile(title: Text(pm.name), subtitle: Text(pm.description))),
      ],
    );
  }
}
