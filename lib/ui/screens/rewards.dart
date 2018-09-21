import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/rewardpool.dart';
import '../../network/state.dart';

class BountyRewards extends StatefulWidget {
  BountyRewards({Key key, this.missionTYpe, this.rewards}) : super(key: key);

  final List<String> rewards;
  final String missionTYpe;

  createState() => _BountyRewards();
}

class _BountyRewards extends State<BountyRewards> {
  List<Rewards> _rewards = [];
  bool isLoading = true;

  Future<Null> getRewards() async {
    List<Rewards> rewards = [];

    for (int i = 0; i < widget.rewards.length; i++) {
      final reward = await SystemState.rewards(widget.rewards[i]);
      rewards.add(reward);
    }

    if (mounted)
      setState(() {
        _rewards = rewards;
        isLoading = false;
      });
  }

  @override
  void initState() {
    super.initState();
    getRewards();
  }

  @override
  void dispose() {
    _rewards = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.missionTYpe)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _rewards.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: CachedNetworkImage(
                              imageUrl: _rewards[index].path,
                              height: 65.0,
                              width: 70.0,
                              fit: BoxFit.fitHeight)),
                      Text(
                        widget.rewards[index],
                        style: color(_rewards[index].level),
                      )
                    ]),
                  )
                ]);
              }),
    );
  }
}

color(String level) {
  switch (level) {
    case 'common':
      return TextStyle(
          color: Color.fromRGBO(205, 127, 50, 1.0), fontSize: 20.0);
    case 'uncommon':
      return TextStyle(color: Colors.white, fontSize: 20.0);
    case 'rare':
      return TextStyle(color: Color.fromRGBO(255, 215, 0, 1.0), fontSize: 20.0);
    default:
      return TextStyle(color: Colors.red, fontSize: 20.0);
  }
}
