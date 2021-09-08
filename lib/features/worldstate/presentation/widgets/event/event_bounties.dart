import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';

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
        return NavisDialog(
          title: Text(type),
          contentPadding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final reward in rewards) ListTile(title: Text(reward))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(MaterialLocalizations.of(context).closeButtonLabel))
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

    return CustomCard(
      child: Column(children: <Widget>[
        CategoryTitle(
          title: context.l10n.bountyTitle,
          style: category,
        ),
        const SizedBox(height: 2),
        ..._buildBounties(context)
      ]),
    );
  }
}
