import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.options});

  final List<SimpleTopics> options;

  static Future<void> showFilters(BuildContext context, List<SimpleTopics> options) {
    final usersettings = BlocProvider.of<SettingsCubit>(context);

    return showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (_) {
        return BlocProvider.value(
          value: usersettings,
          child: FilterDialog(options: options),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavisDialog(
      title: const Text('Options'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[for (final t in options) _NotificationCheckBox(title: t.title, topic: t.value)],
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

  @override
  Widget build(BuildContext context) {
    final toggles = context.watch<SettingsCubit>().state.notifications;

    return CheckboxListTile(
      title: Text(title),
      value: toggles[topic.name] ?? false,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (b) => context.read<SettingsCubit>().toggleFilter(topic.name, enable: b ?? false),
    );
  }
}
