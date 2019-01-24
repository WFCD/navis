import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/routes/syndicates/rewards.dart';

class Event extends StatelessWidget {
  final Events event;

  Event({this.event});

  _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else if (health < 10.0) return Colors.red;
  }

  _addReward(BuildContext context, bool bounty, List<Widget> children) {
    if (bounty) {
      children.addAll(event.jobs.map((j) => _buildJob(context, j)));
    } else {
      children.add(StaticBox.text(
          color: Colors.green,
          text:
              '${event.rewards.first.itemString} + ${event.rewards.first.credits}cr'));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    final victimNode =
        StaticBox.text(text: event.victimNode, color: Colors.red);

    final progress = StaticBox.text(
      text: '${event.health}% Remaining',
      color: _healthColor(double.parse(event.health)),
    );

    _addReward(context, event.jobs.isEmpty, children);

    return SizedBox(
        height: 125,
        child: Material(
            color: Theme.of(context).cardColor,
            elevation: 6,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      child: Text(event.description,
                          style: Theme.of(context).textTheme.title)),
                  Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(event.tooltip,
                          style: Theme.of(context).textTheme.subtitle)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        victimNode,
                        SizedBox(width: 4),
                        progress
                      ]),
                  SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children)
                ])));
  }
}

Widget _buildJob(BuildContext context, Jobs job) {
  return Card(
    color: Colors.blueAccent[400],
    child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BountyRewards(
                missionTYpe: job.type, bountyRewards: job.rewardPool))),
        child: Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(job.type,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(fontSize: 13, color: Colors.white)))),
  );
}
