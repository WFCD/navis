import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc theme = BlocProvider.of<ThemeBloc>(context);
    final bool brightness = Theme.of(context).brightness == Brightness.dark;

    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Appearance',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(fontSize: 15)))),
      ListTile(
          title: const Text('Theme'),
          subtitle: Text(brightness ? 'Dark' : 'Light'),
          onTap: () => _showOptions(context, theme)),
      //Divider(color: Theme.of(context).accentColor),
      ListTile(
          title: const Text('Accent Color'),
          subtitle: const Text(
              'Color used to tint mainly the Appbar and certaint text elements'),
          onTap: () => _showAccents(context, theme))
    ]);
  }
}

Future<void> _showAccents(BuildContext context, ThemeBloc theme) async {
  final currentAccentColor = theme.currentState.theme.accentColor;

  Color tempColor;

  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Text('Select Color'),
          contentPadding: const EdgeInsets.all(6.0),
          content: MaterialColorPicker(
            selectedColor: currentAccentColor,
            onColorChange: (color) => tempColor = color,
            onMainColorChange: (color) => tempColor = color,
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('RESET'),
              textColor: Theme.of(context).textTheme.title.color,
              onPressed: () {
                theme.dispatch(ThemeStart());
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('APPLY'),
              textColor: Theme.of(context).textTheme.title.color,
              onPressed: () {
                theme.dispatch(ThemeCustom(accentColor: tempColor));
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

Future<void> _showOptions(BuildContext context, ThemeBloc theme) async {
  final currentBrightness = theme.currentState.theme.brightness;
  final currentAccentColor = theme.currentState.theme.accentColor;

  void dismiss(Brightness value) {
    theme.dispatch(ThemeChange(brightness: value));
    Navigator.of(context).pop();
  }

  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Text('Select Theme'),
          elevation: 6.0,
          backgroundColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(6.0),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile(
                  activeColor: currentAccentColor,
                  value: Brightness.dark,
                  groupValue: currentBrightness,
                  onChanged: dismiss,
                  title: const Text('Dark'),
                ),
                RadioListTile(
                  activeColor: currentAccentColor,
                  value: Brightness.light,
                  groupValue: currentBrightness,
                  onChanged: dismiss,
                  title: const Text('Light'),
                ),
              ]),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).textTheme.title.color,
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
