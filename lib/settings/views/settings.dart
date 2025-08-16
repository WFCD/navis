import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:intl/intl.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  Future<void> _onNotificationChanged(BuildContext context, Topic topic, bool value) async {
    final repo = context.read<NotificationRepository>();
    context.read<UserSettingsCubit>().updateToggle(topic.name, value: value);

    await repo.requestPermission();
    await repo.updateTopic(topic, value: value);

    final hasPermission = await repo.hasPermission();
    if (!hasPermission && context.mounted) {
      context.read<UserSettingsCubit>().updateToggle(topic.name, value: false);
    }
  }

  void _openDialog(BuildContext context, List<SimpleTopics> filters) {
    FilterDialog.showFilters(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = SettingsThemeData(
      titleTextColor: context.theme.colorScheme.primary,
      settingsListBackground: context.theme.scaffoldBackgroundColor,
    );

    final filters = NotificationTopics(context.l10n);

    final settings = context.select<UserSettingsCubit, UserSettingsSuccess?>(
      (cubit) => cubit.state is UserSettingsSuccess ? cubit.state as UserSettingsSuccess : null,
    );

    final profile = context.select<ProfileCubit, DriftProfileData?>(
      (cubit) => cubit.state is ProfileSuccessful ? (cubit.state as ProfileSuccessful).profile : null,
    );

    final toggles = settings?.toggles ?? <String, bool>{};

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
                  ? UserTitle(username: profile!.username)
                  : Text(l10n.enterUsernameHintText),
              // TODO(Orn): find a way to show mastery progress
              onPressed: profile?.username != null ? null : ProfileWizard.startWizard,
            ),
            if (profile?.username != null)
              SettingsTile(
                title: Text('Clear User', style: TextStyle(color: context.theme.colorScheme.error)),
                onPressed: (_) => BlocProvider.of<ProfileCubit>(context).reset(),
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
              value: Text(toBeginningOfSentenceCase((settings?.themeMode ?? ThemeMode.system).name) ?? ''),
              onPressed: ThemePicker.showModes,
            ),
            SettingsTile.switchTile(
              title: Text(l10n.optOutOfAnalyticsTitle),
              description: Text(l10n.optOutOfAnalyticsDescription),
              initialValue: settings?.isOptOut ?? false,
              onToggle: (b) => context.read<UserSettingsCubit>().updateAnalyticsOpt(isOptOut: b),
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
                initialValue: toggles[topic.topic.name],
                onToggle: (b) => _onNotificationChanged(context, topic.topic, b),
              ),
            for (final mt in filters.filtered)
              SettingsTile.navigation(
                title: Text(mt.title),
                description: Text(mt.description),
                onPressed: (context) => _openDialog(context, mt.filters),
              ),
          ],
        ),
        SettingsSection(
          title: Text(l10n.aboutCategoryTitle),
          tiles: [
            SettingsTile.navigation(
              title: Text(l10n.contributeTranslationsTitle),
              description: Text(l10n.contributeTranslationsDescription),
              onPressed: (context) => contributeTranslations.launchLink(context),
            ),
            SettingsTile.navigation(
              title: Text(l10n.supportTitle('').trim()),
              description: const Text('Everything from tech support to supporting app maintance'),
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
