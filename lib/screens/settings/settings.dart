import 'package:flutter/material.dart';
import 'package:navis/components/styles/platform_choices.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/screens/settings/components/about_app.dart';

import 'components/display_choice.dart';
import 'components/notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(height: 8.0);

    final children = [
      const SizedBox(),
      const PlatformChoice(),
      const DisplayChoices(),
      const Notifications(),
      AboutApp()
    ];

    return Scaffold(
        key: settings,
        appBar: AppBar(title: const Text('Settings')),
        body: ListView.separated(
          itemCount: children.length,
          separatorBuilder: (BuildContext context, int index) => padding,
          itemBuilder: (BuildContext context, int index) => children[index],
        ));
  }
}
