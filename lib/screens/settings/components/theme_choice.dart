import 'package:flutter/material.dart';
import 'package:navis/components/dialogs.dart';
import 'package:navis/components/layout.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool brightness = Theme.of(context).brightness == Brightness.dark;

    return Container(
        child: Column(children: <Widget>[
      const SettingTitle(title: 'Appearance'),
      ListTile(
          title: const Text('Theme'),
          subtitle: Text(brightness ? 'Dark' : 'Light'),
          onTap: () => BaseThemePickerDialog.showBaseThemePicker(context)),
      //Divider(color: Theme.of(context).accentColor),
      ListTile(
          title: const Text('Primary Color'),
          subtitle: const Text('Most visible color'),
          onTap: () => ColorPickerDialog.selectPrimary(context)),
      ListTile(
          title: const Text('Accent Color'),
          subtitle: const Text('Color used to tint certaint text elements'),
          onTap: () => ColorPickerDialog.selectAccent(context))
    ]));
  }
}
