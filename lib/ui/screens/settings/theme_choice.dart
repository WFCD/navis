import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc theme = BlocProvider.of<ThemeBloc>(context);

    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Appearance',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ))
            ],
          )),
      ListTile(
          title: const Text('Theme'),
          subtitle: Text(Theme.of(context).brightness == Brightness.dark
              ? 'Dark'
              : 'Light'),
          onTap: () => showOptions(context, theme))
    ]);
  }
}

Future<void> showOptions(BuildContext context, ThemeBloc theme) {
  final Color accentColor = Theme.of(context).accentColor;
  final Brightness groupValue = Theme.of(context).brightness;

  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BlocBuilder<ThemeEvent, ThemeState>(
            bloc: theme,
            builder: (_, themeState) {
              return SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Select Theme'),
                  children: <Widget>[
                    RadioListTile<Brightness>(
                        title: const Text('Dark'),
                        activeColor: accentColor,
                        value: Brightness.dark,
                        groupValue: groupValue,
                        onChanged: (Brightness value) {
                          theme.dispatch(ThemeDark());
                          Navigator.pop(context);
                        }),
                    RadioListTile<Brightness>(
                        title: const Text('Light'),
                        activeColor: accentColor,
                        value: Brightness.light,
                        groupValue: groupValue,
                        onChanged: (Brightness value) {
                          theme.dispatch(ThemeLight());
                          Navigator.pop(context);
                        }),
                    ButtonTheme.bar(
                        child: ButtonBar(children: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.body1.color)))
                    ]))
                  ]);
            });
      });
}
