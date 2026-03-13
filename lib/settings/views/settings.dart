import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:intl/intl.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_models/profile_models.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  // Future<void> _onNotificationChanged(BuildContext context, Topic topic, bool value) async {
  //   final repo = context.read<NotificationRepository>();
  //   final hasPermission = repo.hasPermission;

  //   if (await hasPermission()) await repo.requestPermission();

  //   if (!(await hasPermission()) && context.mounted) {
  //     context.read<UserSettingsCubit>().updateToggle(topic.name, value: value);
  //     await repo.updateTopic(topic, value: value);
  //   }
  // }

  // void _openDialog(BuildContext context, List<SimpleTopics> filters) {
  //   FilterDialog.showFilters(context, filters);
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = SettingsThemeData(
      titleTextColor: context.theme.colorScheme.primary,
      settingsListBackground: context.theme.scaffoldBackgroundColor,
    );

    final profile = context.select<ProfileCubit, Profile?>(
      (cubit) => cubit.state is ProfileSuccessful ? (cubit.state as ProfileSuccessful).profile : null,
    );

    final themeMode = context.select<AppConfigBloc, ThemeMode>(
      (bloc) => switch (bloc.state) {
        AppConfigUpdated(:final config) => ThemeMode.values[config.theme],
        _ => ThemeMode.system,
      },
    );

    final isOptOut = context.select<AppConfigBloc, bool>(
      (bloc) => switch (bloc.state) {
        AppConfigUpdated(:final config) => config.optOut,
        _ => false,
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
              title: profile?.username != null
                  ? UserTitle(
                      username: profile!.username,
                      rank: profile.masteryRank,
                    )
                  : Text(l10n.enterUsernameHintText),
              onPressed: ProfileWizard.startWizard,
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
              value: Text(toBeginningOfSentenceCase(themeMode.name)),
              onPressed: ThemePicker.showModes,
            ),
            SettingsTile.switchTile(
              title: Text(l10n.optOutOfAnalyticsTitle),
              description: Text(l10n.optOutOfAnalyticsDescription),
              initialValue: isOptOut,
              onToggle: (b) {
                context.read<AppConfigBloc>().add(AppConfigUpdate(optOut: b));
                MatomoTracker.instance.setOptOut(optOut: b);
              },
            ),
          ],
        ),
        // SettingsSection(
        //   title: Text(l10n.notificationsTitle),
        //   tiles: [
        //     for (final topic in filters.simpleFilters)
        //       SettingsTile.switchTile(
        //         title: Text(topic.title),
        //         description: Text(topic.description ?? ''),
        //         initialValue: toggles[topic.topic.name],
        //         onToggle: (b) => _onNotificationChanged(context, topic.topic, b),
        //       ),
        //     for (final mt in filters.filtered)
        //       SettingsTile.navigation(
        //         title: Text(mt.title),
        //         description: Text(mt.description),
        //         onPressed: (context) => _openDialog(context, mt.filters),
        //       ),
        //   ],
        // ),
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
