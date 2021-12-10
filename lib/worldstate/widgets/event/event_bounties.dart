import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class EventBounties extends StatelessWidget {
  const EventBounties({Key? key, required this.jobs}) : super(key: key);

  final List<Job> jobs;

  List<Widget> _buildBounties(BuildContext context) {
    return jobs.map<Widget>((j) {
      return ListTile(
        title: Text(j.type ?? ''),
        subtitle: Text(
          context.l10n.levelInfo(j.enemyLevels.first, j.enemyLevels.last),
        ),
        onTap: () => _showDialog(context, j.type ?? '', j.rewardPool),
      );
    }).toList();
  }

  void _showDialog(BuildContext context, String type, List<String> rewards) {
    final size = MediaQuery.of(context).size;
    final horizontal = (size.width / 100) * 2;
    final vertical = (size.height / 100) * .5;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(type),
          contentPadding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          children: <Widget>[
            for (final reward in rewards) ListTile(title: Text(reward))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category =
        theme.textTheme.subtitle1?.copyWith(color: theme.colorScheme.secondary);

    return AppCard(
      child: Column(
        children: <Widget>[
          CategoryTitle(
            title: context.l10n.bountyTitle,
            style: category,
          ),
          SizedBoxSpacer.spacerHeight2,
          ..._buildBounties(context)
        ],
      ),
    );
  }
}
