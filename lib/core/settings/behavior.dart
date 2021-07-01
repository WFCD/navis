import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../../l10n/l10n.dart';
import '../notifiers/user_settings_notifier.dart';
import '../widgets/widgets.dart';

class Behavior extends StatelessWidget {
  const Behavior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(children: <Widget>[
      const CategoryTitle(title: 'Behavior'),
      ListTile(
        title: Text(l10n.appLangTitle),
        subtitle: Text(l10n.appLangDescription),
        onTap: () => LanguagePicker.showOptions(context),
      ),
      ListTile(
        title: Text(l10n.themeTitle),
        subtitle: Text(l10n.themeDescription),
        onTap: () => ThemePicker.showModes(context),
      ),
      SwitchListTile(
        title: Text(l10n.backOpensDrawerTitle),
        subtitle: Text(l10n.backOpensDrawerDescription),
        value: context.watch<UserSettingsNotifier>().backKey,
        activeColor: Theme.of(context).accentColor,
        onChanged: context.read<UserSettingsNotifier>().toggleBackKey,
      )
    ]);
  }
}

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  static Future<void> showOptions(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<UserSettingsNotifier>(context),
          child: const LanguagePicker(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = NavisLocalizations.supportedLocales;
    final accentColor = Theme.of(context).accentColor;

    return NavisDialog(
      content: ListView.builder(
          itemCount: supportedLocales.length,
          itemBuilder: (context, index) {
            return RadioListTile<Locale>(
              title: Text(supportedLocales[index].fullName),
              value: supportedLocales[index],
              groupValue: context.watch<UserSettingsNotifier>().language,
              activeColor: accentColor,
              onChanged: (l) => context
                  .read<UserSettingsNotifier>()
                  .setLanguage(l, rebuild: true),
            );
          }),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<SolsystemBloc>(context).update(forceUpdate: true);
            Navigator.of(context).pop();
          },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        )
      ],
    );
  }
}

class ThemePicker extends StatelessWidget {
  const ThemePicker({Key? key}) : super(key: key);

  static Future<void> showModes(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<UserSettingsNotifier>(context),
          child: const ThemePicker(),
        );
      },
    );
  }

  void _onChanged(BuildContext context, ThemeMode? mode) {
    if (mode != null) context.read<UserSettingsNotifier>().setTheme(mode);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final accentColor = Theme.of(context).accentColor;

    return NavisDialog(
      title: Text(l10n.themeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<ThemeMode>(
            title: Text(l10n.lightThemeTitle),
            value: ThemeMode.light,
            groupValue: context.watch<UserSettingsNotifier>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.darkThemeTitle),
            value: ThemeMode.dark,
            groupValue: context.watch<UserSettingsNotifier>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.systemThemeTitle),
            value: ThemeMode.system,
            groupValue: context.watch<UserSettingsNotifier>().theme,
            activeColor: accentColor,
            onChanged: (b) => _onChanged(context, b),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        )
      ],
    );
  }
}
