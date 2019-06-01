import 'package:flutter/material.dart';
import 'package:navis/global_keys.dart';

import 'components/about.dart';
import 'components/display_choice.dart';
import 'components/notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: settings,
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          children: <Widget>[
            const DisplayChoices(),
            Notifications(),
            Miscellaneous()
          ],
        ));
  }
}
