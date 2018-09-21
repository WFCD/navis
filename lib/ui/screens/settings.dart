import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app_model.dart';
import '../../resources/assets.dart';
import '../../resources/preferences.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  Preferences prefs;
  String _platform;

  void writePlatform(String platform) async {
    await prefs.setPlatform(platform);
    setState(() {
      _platform = platform;
    });
  }

  void readPlatform() async {
    final platform = await prefs.getPlatform();
    setState(() {
      _platform = platform;
    });
  }

  @override
  void initState() {
    super.initState();
    prefs = Preferences();

    readPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Choose your side',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ))
                      ],
                    )),
                Divider(
                  color: Theme.of(context).accentColor,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                            icon: Icon(ImageAssets.pc),
                            color: _platform == 'pc'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).disabledColor,
                            onPressed: () {
                              writePlatform('pc');
                              model.update();
                            }),
                      ),
                      Container(
                          child: IconButton(
                              icon: Icon(ImageAssets.ps4),
                              color: _platform == 'ps4'
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).disabledColor,
                              onPressed: () {
                                writePlatform('ps4');
                                model.update();
                              })),
                      Container(
                          child: IconButton(
                              icon: Icon(ImageAssets.xbox),
                              color: _platform == 'xb1'
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).disabledColor,
                              onPressed: () {
                                writePlatform('xb1');
                                model.update();
                              }))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
