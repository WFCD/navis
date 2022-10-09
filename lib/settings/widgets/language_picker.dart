import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

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
