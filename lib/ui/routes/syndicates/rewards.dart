import 'package:flutter/material.dart';

class BountyRewards extends StatelessWidget {
  const BountyRewards({Key key, this.missionTYpe, this.bountyRewards})
      : super(key: key);

  final List<String> bountyRewards;
  final String missionTYpe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(missionTYpe)),
        body: ListView.builder(
            itemCount: bountyRewards.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: Center(
                  child: ListTile(
                      title: Text(bountyRewards[index],
                          style: const TextStyle(fontSize: 17.0))),
                ),
              );
            }));
  }
}
