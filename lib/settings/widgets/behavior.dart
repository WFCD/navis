import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';

class Behavior extends StatelessWidget {
  const Behavior({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: <Widget>[
        const CategoryTitle(title: 'Behavior'),
        ListTile(
          title: Text(l10n.appLangTitle),
          subtitle: Text(l10n.appLangDescription),
          onTap: () => _LanguagePicker.showOptions(context),
        ),
        ListTile(
          title: Text(l10n.themeTitle),
          subtitle: Text(l10n.themeDescription),
          onTap: () => _ThemePicker.showModes(context),
        ),
        CheckboxListTile(
          title: Text(l10n.enableBetaFeaturesTitle),
          subtitle: Text(l10n.enableBetaFeaturesDescription),
          value: context.watch<UserSettingsNotifier>().enableBeta,
          onChanged: (value) => context
              .read<UserSettingsNotifier>()
              .setBeta(value: value ?? false),
        ),
      ],
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({super.key});

  static Future<void> showOptions(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<UserSettingsNotifier>(context),
          child: const _LanguagePicker(),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pop();
    BlocProvider.of<SolsystemCubit>(context).fetchWorldstate(forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = NavisLocalizations.supportedLocales;

    final materialLocalizations = MaterialLocalizations.of(context);
    final accentColor = Theme.of(context).colorScheme.secondary;

    return NavisDialog(
      content: ListView.builder(
        itemCount: supportedLocales.length,
        itemBuilder: (context, index) {
          final l = supportedLocales[index];

          return RadioListTile<Locale>(
            title: Text(l.fullName),
            value: l,
            groupValue: context.watch<UserSettingsNotifier>().language,
            activeColor: accentColor,
            onChanged: (l) =>
                context.read<UserSettingsNotifier>().setLanguage(l),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(materialLocalizations.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () => _onPressed(context),
          child: Text(materialLocalizations.okButtonLabel),
        ),
      ],
    );
  }
}

class _ThemePicker extends StatelessWidget {
  const _ThemePicker({super.key});

  static Future<void> showModes(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<UserSettingsNotifier>(context),
          child: const _ThemePicker(),
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
