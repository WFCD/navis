import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ThemeChoice extends StatefulWidget {
  @override
  ThemeChoiceState createState() => ThemeChoiceState();
}

class ThemeChoiceState extends State<ThemeChoice> {
  void _openDialog({String title, Widget content, Widget action}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text(title),
            content: content,
            actions: [action],
          ),
    );
  }

  void _baseTheme(ThemeBloc theme) {
    final currentBrightness = theme.currentState.theme.brightness;
    final currentAccentColor = theme.currentState.theme.accentColor;

    _openDialog(
        title: 'Select your Theme',
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RadioListTile(
                activeColor: currentAccentColor,
                value: Brightness.dark,
                groupValue: currentBrightness,
                title: const Text('Dark'),
                onChanged: (value) {
                  theme.dispatch(ThemeChange(brightness: value));
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                activeColor: currentAccentColor,
                value: Brightness.light,
                groupValue: currentBrightness,
                title: const Text('Light'),
                onChanged: (value) {
                  theme.dispatch(ThemeChange(brightness: value));
                  Navigator.of(context).pop();
                },
              ),
            ]),
        action: FlatButton(
          textColor: Theme.of(context).textTheme.title.color,
          child: const Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ));
  }

  void _primaryColor(ThemeBloc theme) {
    final currentAccentColor = theme.currentState.theme.primaryColor;
    Color tempColor;

    _openDialog(
        title: 'Select Color',
        content: MaterialColorPicker(
          selectedColor: currentAccentColor,
          onColorChange: (color) => tempColor = color,
          onMainColorChange: (color) => tempColor = color,
        ),
        action: FlatButton(
          textColor: Theme.of(context).textTheme.title.color,
          child: const Text('APPLY'),
          onPressed: () {
            theme.dispatch(ThemeCustom(primaryColor: tempColor));
            Navigator.of(context).pop();
          },
        ));
  }

  void _accentColor(ThemeBloc theme) {
    final currentAccentColor = theme.currentState.theme.accentColor;
    Color tempColor;

    _openDialog(
        title: 'Select Color',
        content: MaterialColorPicker(
          selectedColor: currentAccentColor,
          onColorChange: (color) => tempColor = color,
          onMainColorChange: (color) => tempColor = color,
        ),
        action: FlatButton(
          textColor: Theme.of(context).textTheme.title.color,
          child: const Text('APPLY'),
          onPressed: () {
            theme.dispatch(ThemeCustom(accentColor: tempColor));
            Navigator.of(context).pop();
          },
        ));
  }

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
          onTap: () => _baseTheme(theme)),
      //Divider(color: Theme.of(context).accentColor),
      ListTile(
          title: const Text('Primary Color'),
          subtitle: const Text('Most visible color'),
          onTap: () => _primaryColor(theme)),
      ListTile(
          title: const Text('Accent Color'),
          subtitle: const Text('Color used to tint certaint text elements'),
          onTap: () => _accentColor(theme))
    ]);
  }
}
