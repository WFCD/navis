import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile_setup/profile_setup.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = SettingsThemeData(
      titleTextColor: context.theme.colorScheme.primary,
      settingsListBackground: context.theme.scaffoldBackgroundColor,
    );

    final filters = NotificationTopics(context.l10n);
    final settings = context.watch<SettingsCubit>().state;
    final toggles = settings.notifications;

    final profile = context.select<ProfileCubit, Profile?>(
      (c) => switch (c.state) {
        ProfileSuccessful(:final profile) => profile,
        _ => null,
      },
    );

    return SettingsList(
      platform: DevicePlatform.android,
      lightTheme: theme,
      darkTheme: theme,
      sections: [
        SettingsSection(
          title: const Text('Inventoria'),
          tiles: [
            SettingsTile(
              title: profile != null
                  ? UserTitle(
                      username: profile.username,
                      rank: profile.masteryRank,
                    )
                  : Text(l10n.enterUsernameHintText),
              onPressed: SetupView.openBottomSheet,
            ),
            SettingsTile(
              title: const Text('Update Codex'),
              onPressed: (context) async {},
            ),
          ],
        ),
        SettingsSection(
          title: Text(l10n.behaviorTitle),
          tiles: [
            SettingsTile.navigation(
              title: Text(l10n.appLangTitle),
              description: Text(l10n.appLangDescription),
              value: Text(context.locale.fullName),
              onPressed: LanguagePicker.showOptions,
            ),
            SettingsTile.navigation(
              title: Text(l10n.themeTitle),
              description: Text(l10n.themeDescription),
              value: Text(toBeginningOfSentenceCase(settings.themeMode.name)),
              onPressed: ThemePicker.showModes,
            ),
            SettingsTile.switchTile(
              title: Text(l10n.optOutOfAnalyticsTitle),
              description: Text(l10n.optOutOfAnalyticsDescription),
              initialValue: settings.isOptOut,
              onToggle: (b) => context.read<SettingsCubit>().updateAnalyticsOpt(b),
            ),
          ],
        ),
        SettingsSection(
          title: Text(l10n.notificationsTitle),
          tiles: [
            for (final topic in filters.simpleFilters)
              SettingsTile.switchTile(
                title: Text(topic.title),
                description: Text(topic.description ?? ''),
                initialValue: toggles[topic.value.name],
                onToggle: (b) => context.read<SettingsCubit>().toggleFilter(topic.value.name, enable: b),
              ),
            for (final mt in filters.filtered)
              SettingsTile.navigation(
                title: Text(mt.title),
                description: Text(mt.description),
                onPressed: (context) => FilterDialog.showFilters(context, mt.filters),
              ),
          ],
        ),
        SettingsSection(
          title: Text(l10n.aboutCategoryTitle),
          tiles: [
            SettingsTile.navigation(
              title: Text(l10n.reportBugsTitle),
              description: Text(l10n.reportBugsDescription),
              onPressed: UserFeedback.show,
            ),
            SettingsTile.navigation(
              title: Text(l10n.contributeTranslationsTitle),
              description: Text(l10n.contributeTranslationsDescription),
              onPressed: (context) =>
                  showModalBottomSheet<void>(context: context, builder: (context) => const _TranslationsSheet()),
            ),
            SettingsTile.navigation(
              title: Text(l10n.supportTitle('').trim()),
              description: Text(l10n.donationDescriptionText),
              onPressed: SupportBottomSheet.showSheet,
            ),
            SettingsTile.navigation(
              title: Text(l10n.aboutAppTitle),
              onPressed: AboutApp.displayDialog,
            ),
          ],
        ),
      ],
    );
  }
}

class _TranslationsSheet extends StatelessWidget {
  const _TranslationsSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(l10n.contributeAppTranslationsTitle),
          subtitle: Text(l10n.contributeAppTranslationsDescription),
          onTap: () => contributeAppTranslations.launchLink(context),
        ),
        ListTile(
          title: Text(l10n.contributeDataTranslationsTitle),
          subtitle: Text(l10n.contributeDataTranslationsDescription),
          onTap: () => contributeDataTranslations.launchLink(context),
        ),
      ],
    );
  }
}
