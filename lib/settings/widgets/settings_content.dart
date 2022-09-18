import 'package:flutter/material.dart';
import 'package:navis/settings/settings.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  static const _children = [
    PlatformSelect(),
    Behavior(),
    Notifications(),
    AboutApp(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _children.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) => _children[index],
    );
  }
}
