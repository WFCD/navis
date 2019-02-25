import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/rewards.dart';

class BountyRewards extends StatelessWidget {
  BountyRewards({Key key, this.missionTYpe, this.bountyRewards})
      : super(key: key);

  final List<String> bountyRewards;
  final String missionTYpe;

  final _rewards = Rewards();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(missionTYpe)),
        body: FutureBuilder<List<Reward>>(
            future: _rewards.rewards(bountyRewards),
            builder:
                (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
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
            }));
  }
}
