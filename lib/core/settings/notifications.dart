import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../injection_container.dart';
import '../../l10n/l10n.dart';
import '../local/user_settings.dart';
import '../services/notifications.dart';
import '../utils/notification_filter.dart';
import '../widgets/widgets.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  void openDialog(BuildContext context, LocalizedFilter filters, String type) {
    switch (type) {
      case 'acolytes':
        FilterDialog.showFilters(context, filters.acolytes);
        break;
      case 'cycles':
        FilterDialog.showFilters(context, filters.planetCycles);
        break;
      case 'resources':
        FilterDialog.showFilters(context, filters.resources);
        break;
      case 'fissures':
        FilterDialog.showFilters(context, filters.fissures);
        break;
      case 'news':
        FilterDialog.showFilters(context, filters.warframeNews);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = LocalizedFilter(context.l10n);

    return Column(children: <Widget>[
      const CategoryTitle(title: 'Notifications'),
      for (Map<String, String> m in filters.simpleFilters)
        _SimpleNotification(
          name: m['name']!,
          description: m['description']!,
          optionKey: m['key']!,
        ),
      for (Map<String, String> k in filters.filtered)
        ListTile(
          title: Text(k['title']!),
          subtitle: Text(k['description']!),
          onTap: () => openDialog(context, filters, k['type']!),
        ),
    ]);
  }
}

void _onChanged(BuildContext context, String key, bool value) {
  context.read<Usersettings>().setToggle(key, value);

  if (value) {
    sl<NotificationService>().subscribeToNotification(key);
  } else {
    sl<NotificationService>().unsubscribeFromNotification(key);
  }
}

class _SimpleNotification extends StatelessWidget {
  const _SimpleNotification({
    Key? key,
    required this.name,
    required this.description,
    required this.optionKey,
  }) : super(key: key);

  final String name;
  final String description;
  final String optionKey;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(name),
      subtitle: Text(description),
      value: context.watch<Usersettings>().getToggle(optionKey),
      activeColor: Theme.of(context).accentColor,
      onChanged: (b) => _onChanged(context, optionKey, b),
    );
  }
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key, required this.options}) : super(key: key);

  final Map<String, String> options;

  static Future<void> showFilters(
      BuildContext context, Map<String, String> options) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: Provider.of<Usersettings>(context),
          child: FilterDialog(options: options),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _options =
        SplayTreeMap<String, String>.from(options, (a, b) => a.compareTo(b));

    return NavisDialog(
      title: const Text('Filter Options'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          for (String key in _options.keys)
            NotificationCheckBox(
              option: _options[key]!,
              optionKey: key,
              value: context.watch<Usersettings>().getToggle(key),
            )
        ]),
      ),
      actions: <Widget>[
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
    required this.option,
    required this.optionKey,
    required this.value,
  }) : super(key: key);

  final String option;
  final String optionKey;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(option),
      value: value,
      activeColor: Theme.of(context).accentColor,
      onChanged: (b) => _onChanged(context, optionKey, b!),
    );
  }
}
