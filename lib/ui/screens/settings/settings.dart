import 'package:flutter/material.dart';

import 'dateformat.dart';
import 'theme_choice.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Column(
          children: <Widget>[ThemeChoice(), const DateformatSetting()],
        ));
  }
}
