import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  static Future<void> showOptions(BuildContext context) async {
    await showModalBottomSheet<Locale>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(value: context.read<AppConfigBloc>(), child: const LanguagePicker()),
    );
  }

  bool _buildWhen(AppConfigState previous, AppConfigState next) {
    final previousLanguage = switch (previous) {
      AppConfigUpdated(:final config) => Locale(config.language),
      _ => null,
    };

    final nextLanguage = switch (next) {
      AppConfigUpdated(:final config) => Locale(config.language),
      _ => null,
    };

    return previousLanguage != nextLanguage;
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = NavisLocalizations.supportedLocales;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: BlocBuilder<AppConfigBloc, AppConfigState>(
                buildWhen: _buildWhen,
                builder: (context, state) {
                  final language = switch (state) {
                    AppConfigUpdated(:final config) => Locale(config.language),
                    _ => context.locale,
                  };

                  return RadioGroup<Locale>(
                    groupValue: language,
                    onChanged: (l) {
                      if (l == null) return;
                      context.read<AppConfigBloc>().add(AppConfigUpdate(language: l.languageCode));
                    },
                    child: ListView.builder(
                      controller: controller,
                      itemCount: supportedLocales.length,
                      itemBuilder: (context, index) {
                        final l = supportedLocales[index];

                        return RadioListTile<Locale>(title: Text(l.fullName), value: l, activeColor: accentColor);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
