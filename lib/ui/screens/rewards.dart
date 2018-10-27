import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/rewardpool.dart';
import '../../network/state.dart';
import '../../resources/assets.dart';

class BountyRewards extends StatefulWidget {
  BountyRewards({Key key, this.missionTYpe, this.rewards}) : super(key: key);

  final List<String> rewards;

  final String missionTYpe;

  createState() => _BountyRewards();
}

class _BountyRewards extends State<BountyRewards> {
  Future<List<Rewards>> getRewards() async {
    List<Rewards> rewards = [];

    for (int i = 0; i < widget.rewards.length; i++)
      rewards.add(await SystemState.rewards(widget.rewards[i]));

    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.missionTYpe)),
        body: FutureBuilder<List<Rewards>>(
            future: getRewards(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Rewards>> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: Center(
                        child: ListTile(
                            leading: snapshot.data[index].imagePath == null
                                ? Icon(ImageAssets.nightmare, size: 50.0)
                                : Image.network(snapshot.data[index].imagePath,
                                scale: 8.0, fit: BoxFit.cover),
                            title: Text(widget.rewards[index],
                                style: TextStyle(fontSize: 17.0))),
                      ),
                    );
                  });
            }));
  }
}
