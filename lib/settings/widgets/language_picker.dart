import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  static Future<void> showOptions(BuildContext context) async {
    final locale = await showModalBottomSheet<Locale>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder:
          (_) => BlocProvider.value(value: BlocProvider.of<UserSettingsCubit>(context), child: const LanguagePicker()),
    );

    if (locale != null || !context.mounted) return;
    context.read<WarframestatRepository>().language = Language.values.byName(locale!.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = NavisLocalizations.supportedLocales;

    final materialLocalizations = MaterialLocalizations.of(context);
    final accentColor = Theme.of(context).colorScheme.secondary;

    final settings = context.watch<UserSettingsCubit>().state;
    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => context.locale,
    };

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                controller: controller,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OverflowBar(
                spacing: 16,
                alignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(materialLocalizations.cancelButtonLabel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(language),
                    child: Text(materialLocalizations.okButtonLabel),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
