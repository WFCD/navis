import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/utils/utils.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class ArchimedeaPage extends StatelessWidget {
  const ArchimedeaPage({super.key, required this.archimedea});

  final Archimedea archimedea;

  @override
  Widget build(BuildContext context) {
    final reset = weeklyReset();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          AppCard(
            child: ListTile(
              title: Text('${context.l10n.archimedeaResetTitle}:'),
              trailing: CountdownTimer(tooltip: MaterialLocalizations.of(context).formatFullDate(reset), expiry: reset),
            ),
          ),
          _ArchimedeaMissionsCategory(missions: archimedea.missions),
          _PersonalModifierCategory(personalModifiers: archimedea.personalModifiers),
          // const Divider(),
          // ListTile(
          //   title: Text(context.l10n.archimedeaWarningTitle),
          //   subtitle: Text(context.l10n.archimedeaWarningSubtitle),
          //   textColor: context.theme.colorScheme.onErrorContainer,
          // ),
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
          (m) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: Text(
                    m.missionType,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: secondary),
                  ),
                ),
                ListTile(
                  title: Text('${l10n.archimedeaDeviationTitle}: ${m.deviation.title}', style: titleStyle),
                  subtitle: Text(m.deviation.description),
                ),
                ...m.risks.map((rv) => _Risk(risk: rv)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonalModifierCategory extends StatelessWidget {
  const _PersonalModifierCategory({required this.personalModifiers});

  final List<PersonalModifiers> personalModifiers;

  void _onExpansionChanged(BuildContext context, {bool isExpanded = false}) {
    if (!isExpanded) return;

    Future<void>.delayed(kThemeAnimationDuration, () {
      if (!context.mounted) return;
      Scrollable.ensureVisible(context, duration: kThemeAnimationDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ExpansionTile(
        shape: LinearBorder.none,
        onExpansionChanged: (value) => _onExpansionChanged(context, isExpanded: value),
        title: Text(context.l10n.archimedeaPersonalModifierTitle),
        children: personalModifiers
            .map((pm) => ListTile(title: Text(pm.title), subtitle: Text(pm.description)))
            .toList(),
      ),
    );
  }
}

class _Risk extends StatelessWidget {
  const _Risk({required this.risk});

  final ArchimedeaRisk risk;

  @override
  Widget build(BuildContext context) {
    final child = ListTile(
      title: Text('${context.l10n.archimedeaRiskTitle}: ${risk.title}'),
      titleTextStyle: context.textTheme.titleSmall,
      subtitle: Text(risk.description),
    );

    if (risk.isElite) {
      const corner = Radius.circular(4);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.only(topLeft: corner, topRight: corner),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Elite',
                style: context.textTheme.labelLarge,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: context.colorScheme.secondaryContainer, width: 4),
              borderRadius: const BorderRadius.only(topLeft: corner, bottomLeft: corner, bottomRight: corner),
            ),
            child: child,
          ),
        ],
      );
    }

    return child;
  }
}
