import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/models/rewardpool.dart';
import 'package:navis/models/trader.dart';

import '../../network/state.dart';
import '../../resources/assets.dart';

class BountyRewards extends StatelessWidget {
  final List<String> bountyRewards;
  final List<Inventory> traderInventory;
  final String missionTYpe;

  BountyRewards(
      {Key key, this.missionTYpe, this.bountyRewards, this.traderInventory})
      : super(key: key);

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
        body: bountyRewards != null
            ? _buildForSyndicates(getRewards(), bountyRewards)
            : _buildForTrader(traderInventory));
  }
}

Widget _buildForSyndicates(Future<List<Reward>> future,
    List<String> bountyRewards) {
  return FutureBuilder<List<Reward>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final reward = snapshot.data[index];

              final rewardIcon = reward.imagePath == null
                  ? Icon(ImageAssets.nightmare, size: 50.0)
                  : Image.network(reward.imagePath,
                  scale: 8.0, fit: BoxFit.cover);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: Center(
                  child: ListTile(
                      leading: rewardIcon,
                      title: Text(bountyRewards[index],
                          style: TextStyle(fontSize: 17.0))),
                ),
              );
            });
      });
}

Widget _buildForTrader(List<Inventory> inventory) {
  return ListView.builder(
      itemCount: inventory.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Center(
            child: ListTile(
                title: Text(inventory[index].item,
                    style: TextStyle(fontSize: 17.0))),
          ),
        );
      });
}
