import 'package:flutter/material.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/core/widgets/category_title.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';
import 'package:provider/provider.dart';

class Behavior extends StatelessWidget {
  const Behavior({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Container(
      child: Column(children: <Widget>[
        const CategoryTitle(title: 'Behavior'),
        ListTile(
          title: Text(localizations.themeTitle),
          subtitle: Text(localizations.themeDescription),
          onTap: () => ThemePicker.showModes(context),
        ),
        SwitchListTile(
          title: Text(localizations.backOpensDrawerTitle),
          subtitle: Text(localizations.backOpensDrawerDescription),
          value: context.watch<Usersettings>().backkey,
          activeColor: Theme.of(context).accentColor,
          onChanged: (b) => context.read<Usersettings>().backkey = b,
        )
      ]),
    );
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
    final localizations = NavisLocalizations.of(context);
    final accentColor = Theme.of(context).accentColor;

    return NavisDialog(
      title: Text(localizations.themeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<ThemeMode>(
            title: Text(localizations.lightThemeTitle),
            value: ThemeMode.light,
            groupValue: context.watch<Usersettings>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(localizations.darkThemeTitle),
            value: ThemeMode.dark,
            groupValue: context.watch<Usersettings>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(localizations.systemThemeTitle),
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
