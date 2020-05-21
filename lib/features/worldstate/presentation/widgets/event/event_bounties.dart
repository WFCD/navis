import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/entities.dart';

class EventBounties extends StatelessWidget {
  const EventBounties({Key key, this.jobs}) : super(key: key);

  final List<Job> jobs;

  List<Widget> _buildBounties(BuildContext context) {
    return jobs.map<Widget>((j) {
      return ListTile(
        title: Text(j.type),
        subtitle: Text('Level: ${j.enemyLevels[0]} - ${j.enemyLevels[1]}'),
        onTap: () => _showDialog(context, j.type, j.rewardPool),
      );
    }).toList();
  }

  void _showDialog(BuildContext context, String type, List<String> rewards) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return NavisDialog(
          title: Text(type),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final reward in rewards) ListTile(title: Text(reward))
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
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
        theme.textTheme.subtitle1.copyWith(color: theme.accentColor);

    return CustomCard(
      child: Column(children: <Widget>[
        CategoryTitle(
          title: NavisLocalizations.of(context).bountyTitle,
          style: category,
          addPadding: true,
        ),
        const SizedBox(height: 2.0),
        if (jobs != null) ..._buildBounties(context)
      ]),
    );
  }
}
