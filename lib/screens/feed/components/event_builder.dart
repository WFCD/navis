import 'package:flutter/material.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/screens/syndicates/components/syndicate_missions.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class EventBuilder extends StatelessWidget {
  const EventBuilder({this.event});

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

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 4);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
                    style: Theme.of(context).textTheme.subtitle)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            if (event.victimNode != null)
              StaticBox.text(text: event.victimNode, color: Colors.red),
            if (event.rewards.where((r) => r.credits > 0).isNotEmpty)
              StaticBox.text(
                text:
                    '${event.rewards.firstWhere((r) => r.credits > 0).credits}cr',
                color: Theme.of(context).primaryColor,
              ),
            space,
            if (event.eventHealth != null)
              StaticBox.text(
                text: '${event.eventHealth} remaining',
                color: _healthColor(event.eventHealth),
              )
            else
              CountdownBox(expiry: event.expiry),
          ]),
          space,
          if (event.jobs?.isNotEmpty ?? false)
            FlatButton(
              child: const Text('See Bounties'),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              onPressed: () => _navigateToBounties(context, event.jobs),
            )
          else
            _addReward(event.eventRewards)
        ]);
  }
}
