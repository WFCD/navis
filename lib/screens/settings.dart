import 'package:flutter/material.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/widgets/settings/settings.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    final children = [
      const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: PlatformChoice(),
      ),
      const DisplayChoices(),
      const Notifications(),
      const AboutApp()
    ];

    return Scaffold(
      key: settings,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView.separated(
        itemCount: children.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) => children[index],
      ),
    );
  }
}
