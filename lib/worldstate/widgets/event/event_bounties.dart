import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class EventBounties extends StatelessWidget {
  const EventBounties({super.key, required this.jobs});

  final List<SyndicateBounty> jobs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.secondary);

    return AppCard(
      child: Column(
        children: <Widget>[
          CategoryTitle(title: context.l10n.bountyTitle, style: category),
          Gaps.gap2,
          _BuildBounties(jobs: jobs),
        ],
      ),
    );
  }
}

class _BuildBounties extends StatelessWidget {
  const _BuildBounties({required this.jobs});

  final List<SyndicateBounty> jobs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: jobs.map<Widget>((j) => SyndicateBountyTile(job: j, color: SyndicateColors.ostronsIconColor)).toList(),
    );
  }
}
