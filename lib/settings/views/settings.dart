import 'package:flutter/material.dart';
import 'package:navis/settings/settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SettingsContent(),
    );
  }
}
