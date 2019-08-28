import 'package:flutter/material.dart';
import 'package:navis/screens/syndicate_bounties.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({this.event});

  final Event event;

  Color _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  Widget _addReward(List<String> rewards) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (String r in rewards) StaticBox.text(color: Colors.green, text: r)
      ],
    );
  }

  void _navigateToBounties(BuildContext context, List<Job> jobs) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SyndicateJobs(
          faction: OpenWorldFactions.cetus,
          jobs: jobs,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
          margin: const EdgeInsets.only(bottom: 4, top: 3),
          child: Text(event.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title)),
      if (event.tooltip != null)
        Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(event.tooltip,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle))
    ]);
  }

  Widget _buildMiddle(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      if (event.victimNode != null)
        StaticBox.text(text: event.victimNode, color: Colors.red),
      if (event.rewards.where((r) => r.credits > 0).isNotEmpty)
        StaticBox.text(
          text: '${event.rewards.firstWhere((r) => r.credits > 0).credits}cr',
          color: Theme.of(context).primaryColor,
        ),
      const SizedBox(height: 4),
      if (event.eventHealth != null)
        StaticBox.text(
          text: '${event.eventHealth.toStringAsFixed(2)}% remaining',
          color: _healthColor(event.eventHealth),
        )
      else
        CountdownBox(expiry: event.expiry),
    ]);
  }

  Widget _buildFooter(BuildContext context) {
    if (event.jobs?.isNotEmpty ?? false) {
      return FlatButton(
        child: const Text('See Bounties'),
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onPressed: () => _navigateToBounties(context, event.jobs),
      );
    } else {
      return _addReward(event.eventRewards);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 4),
          _buildHeader(context),
          const SizedBox(height: 4),
          _buildMiddle(context),
          const SizedBox(height: 8),
          _buildFooter(context)
        ]);
  }
}
