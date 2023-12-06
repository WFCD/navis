import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  static Future<void> showOptions(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        final ws = BlocProvider.of<SolsystemCubit>(context);
        final us = BlocProvider.of<UserSettingsCubit>(context);

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: ws),
            BlocProvider.value(value: us),
          ],
          child: const LanguagePicker(),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pop();
    BlocProvider.of<SolsystemCubit>(context)
        .fetchWorldstate(context.locale, forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = NavisLocalizations.supportedLocales;

    final materialLocalizations = MaterialLocalizations.of(context);
    final accentColor = Theme.of(context).colorScheme.secondary;

    final settings = context.watch<UserSettingsCubit>().state;
    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => context.locale
    };

    return NavisDialog(
      content: ListView.builder(
        itemCount: supportedLocales.length,
        itemBuilder: (context, index) {
          final l = supportedLocales[index];

          return RadioListTile<Locale>(
            title: Text(l.fullName),
            value: l,
            groupValue: language,
            activeColor: accentColor,
            onChanged: (l) {
              if (l == null) return;
              context.read<UserSettingsCubit>().updateLanguage(l);
            },
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
