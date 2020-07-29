import 'package:flutter/material.dart';
import 'package:navis/core/settings/platform_select.dart';

import 'about_app.dart';
import 'behavior.dart';
import 'notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final children = [
      const PlatformSelect(),
      const Behavior(),
      const Notifications(),
      const AboutApp()
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView.separated(
        itemCount: children.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) => children[index],
      ),
    );
  }
}
