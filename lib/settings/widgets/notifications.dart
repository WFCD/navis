import 'package:flutter/material.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/notification_topic_filter.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  void openDialog(BuildContext context, List<SimpleTopics> filters) {
    FilterDialog.showFilters(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    final filters = NotificationTopics(context.l10n);

    return Column(
      children: <Widget>[
        const CategoryTitle(title: 'Notifications'),
        for (final topic in filters.simpleFilters)
          _SimpleNotification(
            name: topic.title,
            description: topic.description!,
            topic: topic.topic,
          ),
        for (final mt in filters.filtered)
          ListTile(
            title: Text(mt.title),
            subtitle: Text(mt.description),
            onTap: () => openDialog(context, mt.filters),
          ),
      ],
    );
  }
}

void _onChanged(BuildContext context, Topic topic, bool value) {
  context.read<UserSettingsNotifier>().setToggle(topic.topic, value: value);

  if (value) {
    sl<NotificationRepository>().subscribeToNotification(topic);
  } else {
    sl<NotificationRepository>().unsubscribeFromNotification(topic);
  }
}

class _SimpleNotification extends StatelessWidget {
  const _SimpleNotification({
    Key? key,
    required this.name,
    required this.description,
    required this.topic,
  }) : super(key: key);

  final String name;
  final String description;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(name),
      subtitle: Text(description),
      value: context.watch<UserSettingsNotifier>().getToggle(topic.topic),
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (b) => _onChanged(context, topic, b),
    );
  }
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key, required this.options}) : super(key: key);

  final List<SimpleTopics> options;

  static Future<void> showFilters(
    BuildContext context,
    List<SimpleTopics> options,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<UserSettingsNotifier>(context),
          child: FilterDialog(options: options),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _options = List<SimpleTopics>.from(options)
      ..sort((a, b) => a.title.compareTo(b.title));

    return NavisDialog(
      title: const Text('Options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final t in _options)
              NotificationCheckBox(
                title: t.title,
                topic: t.topic,
                value: context
                    .watch<UserSettingsNotifier>()
                    .getToggle(t.topic.topic),
              )
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

class NotificationCheckBox extends StatelessWidget {
  const NotificationCheckBox({
    Key? key,
    required this.title,
    required this.topic,
    required this.value,
  }) : super(key: key);

  final String title;
  final Topic topic;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (b) => _onChanged(context, topic, b!),
    );
  }
}
