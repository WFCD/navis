import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../animation/countdown.dart';
import '../animation/route.dart';
import '../json/export.dart';
import '../model.dart';
import 'rewards.dart';

class Ostrons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        var ostrons = model.syndicates[0];
        Duration bountyTime =
            DateTime.parse(ostrons.expiry).difference(DateTime.now());

        final emptyList = Center(
            child: Text('Waiting for new Bounties check back in a minute.',
                style: TextStyle(fontSize: 17.0)));

        return Flex(direction: Axis.vertical, children: <Widget>[
          Expanded(
              child: Column(
                  children: ostrons.jobs.isEmpty
                      ? <Widget>[emptyList]
                      : ostrons.jobs
                          .map((job) => _buildMissionType(context, job))
                          .toList())),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Bounties expire in',
                          style: TextStyle(fontSize: 17.0)),
                      Container(
                          child: StreamBuilder<Duration>(
                              initialData: Duration(minutes: 60),
                              stream: CounterScreenStream(bountyTime),
                              builder: (context, snapshot) {
                                Duration data = snapshot.data;

                                String hour = '${data.inHours}';
                                String minutes =
                                    '${(data.inMinutes % 60).floor()}'
                                        .padLeft(2, '0');
                                String seconds =
                                    '${(data.inSeconds % 60).floor()}'
                                        .padLeft(2, '0');

                                return Text('$hour:$minutes:$seconds',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17.0));
                              }))
                    ]),
              ))
        ]);
      },
    );
  }
}

Widget _buildMissionType(BuildContext context, Jobs job) {
  return Padding(
    padding: EdgeInsets.all(4.0),
    child: Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color.fromRGBO(187, 187, 197, 0.2),
      child: ListTile(
        title: Text(job.type),
        subtitle:
            Text('Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}'),
        trailing: ButtonTheme.bar(
          child: RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () => Navigator.of(context).push(FadeRoute(
                  child: BountyRewards(
                      missionTYpe: job.type, rewards: job.rewardPool))),
              child: Text(
                'Rewards',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    ),
  );
}
