import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.options});

  final List<SimpleTopics> options;

  static Future<void> showFilters(
    BuildContext context,
    List<SimpleTopics> options,
  ) {
    return showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        final notifications =
            RepositoryProvider.of<NotificationRepository>(context);
        final usersettings = BlocProvider.of<UserSettingsCubit>(context);

        return RepositoryProvider.value(
          value: notifications,
          child: BlocProvider.value(
            value: usersettings,
            child: FilterDialog(options: options),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final options = List<SimpleTopics>.from(this.options)
      ..sort((a, b) => a.title.compareTo(b.title));

    return NavisDialog(
      title: const Text('Options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final t in options)
              _NotificationCheckBox(title: t.title, topic: t.topic),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
      ],
    );
  }
}

class _NotificationCheckBox extends StatelessWidget {
  const _NotificationCheckBox({required this.title, required this.topic});

  final String title;
  final Topic topic;

  void _onChanged(BuildContext context, Topic topic, bool value) {
    context.read<UserSettingsCubit>().updateToggle(topic.name, value: value);

    if (value) {
      context.read<NotificationRepository>().subscribeToNotification(topic);
    } else {
      context.read<NotificationRepository>().unsubscribeFromNotification(topic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<UserSettingsCubit>().state;
    final toggles = switch (settings) {
      UserSettingsSuccess() => settings.toggles,
      _ => <String, bool>{}
    };

    return CheckboxListTile(
      title: Text(title),
      value: toggles[topic.name] ?? false,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (b) => _onChanged(context, topic, b ?? false),
    );
  }
}
