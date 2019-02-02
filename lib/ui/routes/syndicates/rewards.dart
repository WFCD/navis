import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/models/export.dart';

import 'package:navis/services/worldstate.dart';

class BountyRewards extends StatelessWidget {
  const BountyRewards({Key key, this.missionTYpe, this.bountyRewards})
      : super(key: key);

  final List<String> bountyRewards;
  final String missionTYpe;

  Future<List<Reward>> getRewards() async {
    final List<Reward> imageList = await WorldstateAPI.rewards();
    final List<Reward> rewards = [];
    final nonexistent = Reward()
      ..rewardName = 'reward doesn\'t exist'
      ..imagePath = null;

    for (int i = 0; i < bountyRewards.length; i++) {
      final image = List.from(imageList);
      try {
        image.retainWhere(
            (image) => bountyRewards[i].contains(image.rewardName) == true);
        rewards.add(image.first);
      } catch (err) {
        rewards.add(nonexistent);
      }
    }

    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(missionTYpe)),
        body: _buildForSyndicates(getRewards(), bountyRewards));
  }
}

Widget _buildForSyndicates(
    Future<List<Reward>> future, List<String> bountyRewards) {
  return FutureBuilder<List<Reward>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final reward = snapshot.data[index];

              final rewardIcon = reward.imagePath == null
                  ? SvgPicture.asset('assets/general/nightmare.svg',
                      color: Colors.red, height: 50, width: 50)
                  : Image.network(reward.imagePath,
                      height: 60, width: 60, fit: BoxFit.cover);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: Center(
                  child: ListTile(
                      leading: rewardIcon,
                      title: Text(bountyRewards[index],
                          style: const TextStyle(fontSize: 17.0))),
                ),
              );
            });
      });
}
