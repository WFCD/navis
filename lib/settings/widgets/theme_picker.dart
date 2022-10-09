import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

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
    final groupValue = context.watch<UserSettingsNotifier>().theme;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return SimpleDialog(
      title: Text(l10n.themeTitle),
      children: [
        RadioListTile<ThemeMode>(
          title: Text(l10n.lightThemeTitle),
          value: ThemeMode.light,
          groupValue: groupValue,
          activeColor: accentColor,
          onChanged: (b) => _onChanged(context, b),
        ),
        RadioListTile<ThemeMode>(
          title: Text(l10n.darkThemeTitle),
          value: ThemeMode.dark,
          groupValue: groupValue,
          activeColor: accentColor,
          onChanged: (b) => _onChanged(context, b),
        ),
        RadioListTile<ThemeMode>(
          title: Text(l10n.systemThemeTitle),
          value: ThemeMode.system,
          groupValue: groupValue,
          activeColor: accentColor,
          onChanged: (b) => _onChanged(context, b),
        ),
        ButtonBar(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          ],
        ),
      ],
    );
  }
}
