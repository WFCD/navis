import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  static Future<void> showModes(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<UserSettingsCubit>(context),
          child: Localizations(
            locale: context.locale,
            delegates: NavisLocalizations.localizationsDelegates,
            child: const ThemePicker(),
          ),
        );
      },
    );
  }

  void _onChanged(BuildContext context, ThemeMode? mode) {
    if (mode == null) return;

    final state = context.read<UserSettingsCubit>().state;
    if (state is UserSettingsSuccess) {
      context.read<UserSettingsCubit>().updateThemeMode(mode);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final l10n = context.l10n;
    final state = context.watch<UserSettingsCubit>().state;
    final currentTheme = switch (state) {
      UserSettingsSuccess() => state.themeMode,
      _ => ThemeMode.light,
    };

    return RadioGroup<ThemeMode>(
      groupValue: currentTheme,
      onChanged: (b) => _onChanged(context, b),
      child: SimpleDialog(
        title: Text(l10n.themeTitle),
        children: [
          RadioListTile<ThemeMode>(
            title: Text(l10n.lightThemeTitle),
            value: ThemeMode.light,
            activeColor: accentColor,
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.darkThemeTitle),
            value: ThemeMode.dark,
            activeColor: accentColor,
          ),
          RadioListTile<ThemeMode>(
            title: Text(l10n.systemThemeTitle),
            value: ThemeMode.system,
            activeColor: accentColor,
          ),
          OverflowBar(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
