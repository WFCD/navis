import 'package:flutter/material.dart';
import 'package:navis/globalkeys.dart';

import 'settings/platform_choices.dart';
import 'settings/theme_choice.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffold,
        appBar: AppBar(title: Text('Settings')),
        body: Column(
          children: <Widget>[
            PlatformChoice(),
            ThemeChoice(),
          ],
        ));
  }
}
