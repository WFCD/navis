import 'package:flutter/material.dart';
import 'package:navis/utils/notification_topic_filter.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.options});

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
    final options = List<SimpleTopics>.from(this.options)
      ..sort((a, b) => a.title.compareTo(b.title));

    return NavisDialog(
      title: const Text('Options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final t in options)
              _NotificationCheckBox(
                title: t.title,
                topic: t.topic,
                value: context
                    .watch<UserSettingsNotifier>()
                    .getToggle(t.topic.name),
              ),
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
  const _NotificationCheckBox({
    required this.title,
    required this.topic,
    required this.value,
  });

  final String title;
  final Topic topic;
  final bool value;

  void _onChanged(BuildContext context, Topic topic, bool value) {
    context.read<UserSettingsNotifier>().setToggle(topic.name, value: value);

    if (value) {
      context.read<NotificationRepository>().subscribeToNotification(topic);
    } else {
      context.read<NotificationRepository>().unsubscribeFromNotification(topic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (b) => _onChanged(context, topic, b ?? false),
    );
  }
}
