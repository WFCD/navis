import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'base_dialog.dart';

class BaseThemePickerDialog extends StatelessWidget with DialogWidget {
  static Future<void> showBaseThemePicker(BuildContext context) async {
    DialogWidget.openDialog(context, BaseThemePickerDialog());
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return BlocBuilder(
      bloc: themeBloc,
      builder: (BuildContext context, ThemeState currentTheme) {
        final activeColor = currentTheme.theme.accentColor;
        final brightness = currentTheme.theme.brightness;

        return BaseDialog(
          dialogTitle: 'Select your Theme',
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile(
                  activeColor: activeColor,
                  value: Brightness.dark,
                  groupValue: brightness,
                  title: const Text('Dark'),
                  onChanged: (value) {
                    themeBloc.dispatch(ThemeChange(brightness: value));
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  activeColor: activeColor,
                  value: Brightness.light,
                  groupValue: brightness,
                  title: const Text('Light'),
                  onChanged: (value) {
                    themeBloc.dispatch(ThemeChange(brightness: value));
                    Navigator.of(context).pop();
                  },
                ),
              ]),
          actions: <Widget>[
            FlatButton(
                child: const Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop())
          ],
        );
      },
    );
  }
}
