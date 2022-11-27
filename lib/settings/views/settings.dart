import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/notification_topic_filter.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:user_settings/user_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SafeArea(child: _SettingsView()),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  void _onNotificationChanged(BuildContext context, Topic topic, bool value) {
    context.read<UserSettingsNotifier>().setToggle(topic.name, value: value);

    if (value) {
      context.read<NotificationRepository>().subscribeToNotification(topic);
    } else {
      context.read<NotificationRepository>().unsubscribeFromNotification(topic);
    }
  }

  void _openDialog(BuildContext context, List<SimpleTopics> filters) {
    FilterDialog.showFilters(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.watch<UserSettingsNotifier>();

    final filters = NotificationTopics(context.l10n);

    return SettingsList(
      sections: [
        const SettingsSection(tiles: [PlatformSelect()]),
        SettingsSection(
          title: const Text('Behavior'),
          tiles: [
            SettingsTile.navigation(
              title: Text(l10n.appLangTitle),
              description: Text(l10n.appLangDescription),
              value: Text(
                settings.language?.fullName ?? 'English',
              ),
              onPressed: LanguagePicker.showOptions,
            ),
            SettingsTile.navigation(
              title: Text(l10n.themeTitle),
              description: Text(l10n.themeDescription),
              value: Text(settings.theme.name),
              onPressed: ThemePicker.showModes,
            ),
            SettingsTile.switchTile(
              title: Text(l10n.optOutOfAnalyticsTitle),
              description: Text(l10n.optOutOfAnalyticsDescription),
              initialValue: settings.isOptOut,
              onToggle: (b) =>
                  context.read<UserSettingsNotifier>().setOptOut(value: b),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Notifications'),
          tiles: [
            for (final topic in filters.simpleFilters)
              SettingsTile.switchTile(
                title: Text(topic.title),
                description: Text(topic.description ?? ''),
                initialValue: settings.getToggle(topic.topic.name),
                onToggle: (b) =>
                    _onNotificationChanged(context, topic.topic, b),
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
          title: const Text('About'),
          tiles: [
            SettingsTile.navigation(
              title: Text(l10n.reportBugsTitle),
              description: Text(l10n.reportBugsDescription),
              onPressed: (context) =>
                  BetterFeedback.of(context).showAndUploadToSentry(),
            ),
            SettingsTile.navigation(
              title: const Text('About app'),
              onPressed: (context) => showDialog<void>(
                context: context,
                builder: (context) => AboutApp(l10n: l10n),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
