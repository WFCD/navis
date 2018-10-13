import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../animation/countdown.dart';
import '../widgets/cards.dart';

class Ostrons extends StatefulWidget {
  @override
  OstronsState createState() => OstronsState();
}

class OstronsState extends State<Ostrons> {
  @override
  Widget build(BuildContext context) {
    final syndicate = BlocProvider.of<WorldstateBloc>(context);

    final emptyList = Center(
        child: Text('Waiting for new Bounties check back in a minute.',
            style: TextStyle(fontSize: 17.0)));

    return StreamBuilder(
        stream: syndicate.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          Duration bountyTime =
          DateTime.parse(snapshot.data.syndicates[0].expiry)
              .difference(DateTime.now());

          return RefreshIndicator(
              onRefresh: () => syndicate.update(),
              child: Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                    child: ListView(
                        children: snapshot.data.syndicates[0].jobs.isEmpty
                            ? <Widget>[emptyList]
                            : snapshot.data.syndicates[0].jobs
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
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .body1
                                                  .color,
                                              fontSize: 17.0));
                                    }))
                          ]),
                    ))
              ]));
        });
  }
}

Widget _buildMissionType(BuildContext context, Jobs job) {
  return Tiles(
    child: ListTile(
      title: Text(job.type),
      subtitle:
      Text('Enemey Level ${job.enemyLevels[0]} - ${job.enemyLevels[1]}'),
      trailing: ButtonTheme.bar(
        child: FlatButton(
            onPressed: () => showRewards(context, job.rewardPool),
            child: Text(
              'See Rewards',
              style: TextStyle(color: Colors.blue),
            )),
      ),
    ),
  );
}

Future<Null> showRewards(BuildContext context, List<String> rewards) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (rewards.length <= 0)
          return AlertDialog(
            title: Text('Error loading rewards'),
            content: Text(
                'It seems that that this bounty doesn\'t have any rewards or the API is having a bit hiccup'),
            actions: <Widget>[
              ButtonTheme.bar(
                  child: ButtonBar(children: <Widget>[
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Dismiss'))
                  ]))
            ],
          );

        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          children: rewards.map((r) => ListTile(title: Text(r))).toList(),
        );
      });
}

/*Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                    child: ListView(
                        children: snapshot.data.syndicates[0].jobs.isEmpty
                            ? <Widget>[emptyList]
                            : snapshot.data.syndicates[0].jobs
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
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .body1
                                                  .color,
                                              fontSize: 17.0));
                                    }))
                          ]),
                    ))
              ])*/
