import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

import '../services/state.dart';

class BountyRewards extends StatefulWidget {
  BountyRewards({Key key, this.missionTYpe, this.rewards}) : super(key: key);

  final List<String> rewards;
  final String missionTYpe;

  createState() => _BountyRewards();
}

class _BountyRewards extends State<BountyRewards> {
  List<String> _urls = [];
  List<String> _levels = [];
  bool isLoading = true;
  Duration _timeout = Duration(minutes: 2);

  Future<Null> getUrls() async {
    List<String> urls = [];
    List<String> levels = [];

    for (int i = 0; i < widget.rewards.length; i++) {
      String reward = await SystemState.rewardImages(widget.rewards[i]);
      String level = await SystemState.rewardColor(widget.rewards[i]);
      urls.add(reward);
      levels.add(level);
    }

    if (mounted)
      setState(() {
        _urls = urls;
        _levels = levels;
        isLoading = false;
      });
  }

  @override
  void initState() {
    super.initState();
    getUrls();
  }

  @override
  void dispose() {
    _urls = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.missionTYpe)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _urls.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Image(
                              fit: BoxFit.fitHeight,
                              height: 65.0,
                              width: 70.0,
                              image: AdvancedNetworkImage(_urls[index],
                                  useDiskCache: true,
                                  useMemoryCache: true,
                                  timeoutDuration: _timeout,
                                  retryDuration: _timeout,
                                  retryLimit: 10))),
                      Text(
                        widget.rewards[index],
                        style: color(_levels[index]),
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
