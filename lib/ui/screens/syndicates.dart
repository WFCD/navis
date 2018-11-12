import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../animation/countdown.dart';
import '../widgets/cards.dart';
import 'rewards.dart';

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

          List<Widget> allJobs = snapshot.data.syndicates[0].jobs
              .map((j) => _buildMissionType(context, j))
              .toList();

          if (snapshot.data.events.isNotEmpty &&
              snapshot.data.events[0].jobs != null) {
            allJobs.addAll(snapshot.data.events[0].jobs
                .map((j) => _buildMissionType(context, j)));
          }

          return RefreshIndicator(
              onRefresh: () => syndicate.update(),
              child: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Bounties expire in',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .body1
                                      .color)),
                          AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: _warnings(bountyTime)),
                              child: StreamBuilder<Duration>(
                                  initialData: Duration(minutes: 60),
                                  stream: CounterScreenStream(bountyTime),
                                  builder: (context, snapshot) =>
                                      _buildTimer(context, snapshot.data)))
                        ])),
                SliverFixedExtentList(
                    delegate: SliverChildListDelegate(
                        snapshot.data.syndicates[0].jobs.isEmpty
                            ? <Widget>[emptyList]
                            : allJobs),
                    itemExtent: 85.0)
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
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        BountyRewards(
                      missionTYpe: job.type,
                      rewards: job.rewardPool,
                    ))),
            child: Text(
              'See Rewards',
              style: TextStyle(color: Colors.blue),
            )),
      ),
    ),
  );
}

Color _warnings(Duration timeLeft) {
  if (timeLeft > Duration(hours: 1))
    return Colors.green;
  else if (timeLeft < Duration(hours: 1) && timeLeft >= Duration(minutes: 30))
    return Colors.orange[700];
  else
    return Colors.red;
}

Widget _buildTimer(BuildContext context, Duration timeLeft) {
  String hour = '${timeLeft.inHours}';
  String minutes = '${(timeLeft.inMinutes % 60).floor()}'.padLeft(2, '0');
  String seconds = '${(timeLeft.inSeconds % 60).floor()}'.padLeft(2, '0');

  return Text('$hour:$minutes:$seconds',
      style: TextStyle(
          color: Theme
              .of(context)
              .textTheme
              .body2
              .color, fontSize: 17.0));
}
