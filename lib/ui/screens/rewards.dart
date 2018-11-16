import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/models/rewardpool.dart';

import '../../network/state.dart';
import '../../resources/assets.dart';

class BountyRewards extends StatelessWidget {
  BountyRewards({Key key, this.missionTYpe, this.bountyRewards})
      : super(key: key);

  final List<String> bountyRewards;
  final String missionTYpe;

  Future<List<Reward>> getRewards() async {
    List<Reward> imageList = await SystemState.rewards();
    List<Reward> rewards = [];

    final nonexistent = Reward()
      ..rewardName = 'reward doesn\'t exist'
      ..imagePath = null;

    bountyRewards.forEach((r) {
      var image = List.from(imageList);
      try {
        image.retainWhere((i) => r.contains(i.rewardName) == true);
        rewards.add(image.first);
      } catch (err) {
        rewards.add(nonexistent);
      }
    });

    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(missionTYpe)),
        body: FutureBuilder<List<Reward>>(
            future: getRewards(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final reward = snapshot.data[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: Center(
                        child: ListTile(
                            leading: reward.imagePath == null
                                ? Icon(ImageAssets.nightmare, size: 50.0)
                                : Image.network(reward.imagePath,
                                    scale: 8.0, fit: BoxFit.cover),
                            title: Text(bountyRewards[index],
                                style: TextStyle(fontSize: 17.0))),
                      ),
                    );
                  });
            }));
  }
}
