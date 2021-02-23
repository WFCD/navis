import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../local/user_settings.dart';
import '../utils/extensions.dart';
import '../widgets/widgets.dart';

class Behavior extends StatelessWidget {
  const Behavior({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const CategoryTitle(title: 'Behavior'),
      ListTile(
        title: Text(context.locale.themeTitle),
        subtitle: Text(context.locale.themeDescription),
        onTap: () => ThemePicker.showModes(context),
      ),
      SwitchListTile(
        title: Text(context.locale.backOpensDrawerTitle),
        subtitle: Text(context.locale.backOpensDrawerDescription),
        value: context.watch<Usersettings>().backkey,
        activeColor: Theme.of(context).accentColor,
        onChanged: (b) => context.read<Usersettings>().backkey = b,
      )
    ]);
  }
}

class ThemePicker extends StatelessWidget {
  const ThemePicker({Key key}) : super(key: key);

  static Future<void> showModes(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<Usersettings>(context),
          child: const ThemePicker(),
        );
      },
    );
  }

  void _onChanged(BuildContext context, ThemeMode mode) {
    context.read<Usersettings>().theme = mode;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return NavisDialog(
      title: Text(context.locale.themeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<ThemeMode>(
            title: Text(context.locale.lightThemeTitle),
            value: ThemeMode.light,
            groupValue: context.watch<Usersettings>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(context.locale.darkThemeTitle),
            value: ThemeMode.dark,
            groupValue: context.watch<Usersettings>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(context.locale.systemThemeTitle),
            value: ThemeMode.system,
            groupValue: context.watch<Usersettings>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        )
      ],
    );
  }
}
