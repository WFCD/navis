import 'package:flutter/material.dart';
import 'package:navis/settings/widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SettingsContent(),
    );
  }
}

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final heightRatio = screenSize.height / 100;
    final widthRatio = screenSize.width / 100;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: heightRatio * 90,
        width: widthRatio * 80,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: SettingsContent(),
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({Key? key}) : super(key: key);

  static const _children = [
    PlatformSelect(),
    Behavior(),
    Notifications(),
    AboutApp()
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
