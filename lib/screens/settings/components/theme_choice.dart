import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'package:navis/components/dialogs.dart';
import 'package:navis/components/layout.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: storage,
      builder: (_, state) {
        final enabled = state.theme.brightness == Brightness.dark;

        return Container(
            child: Column(children: <Widget>[
          const SettingTitle(title: 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text('${enabled ? 'Disable' : 'Enable'} dark mode'),
            value: enabled,
            activeColor: Theme.of(context).accentColor,
            onChanged: (b) => storage.dispatch(ChangeThemeData(enableDark: b)),
          ),
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
      },
    );
  }
}
