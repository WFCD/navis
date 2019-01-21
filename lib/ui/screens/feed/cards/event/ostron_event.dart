import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/routes/syndicates/rewards.dart';

class BountyEvent extends StatelessWidget {
  final Events event;

  BountyEvent({this.event});

  _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else if (health < 10.0) return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final jobs = event.jobs.map((j) {
      return Card(
        color: Colors.blueAccent[400],
        child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BountyRewards(
                    missionTYpe: j.type, bountyRewards: j.rewardPool))),
            child: Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Text(j.type,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontSize: 13, color: Colors.white)))),
      );
    }).toList();

    final victimNode = StaticBox(
        child: Text(event.victimNode,
            style: TextStyle(fontSize: 13, color: Colors.white)),
        color: Colors.red);

    final progress = StaticBox(
      child: Text('${event.health}% Remaining',
          style: TextStyle(fontSize: 13, color: Colors.white)),
      color: _healthColor(double.parse(event.health)),
    );

    return SizedBox(
        height: 125,
        child: Material(
            color: Theme.of(context).canvasColor,
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
                      children: jobs)
                ])));
  }
}
