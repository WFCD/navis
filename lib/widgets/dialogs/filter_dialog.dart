import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/widgets/common/resource_watcher.dart';

import 'base_dialog.dart';

enum FilterType { acolytes, news, cycles, resources }

class FilterDialog extends StatelessWidget {
  const FilterDialog({this.options, this.type});

  final Map<String, String> options;
  final FilterType type;

  static Future<void> showFilters(BuildContext context,
      Map<String, String> options, FilterType type) async {
    showDialog(
        context: context,
        builder: (_) => FilterDialog(options: options, type: type));
  }

  Map<String, bool> _typeToInstance(PersistentResource storage) {
    switch (type) {
      case FilterType.acolytes:
        return storage.acolytes;
      case FilterType.news:
        return storage.news;
      case FilterType.cycles:
        return storage.cycles;
      case FilterType.resources:
        return storage.resources;
      default:
        return <String, bool>{};
    }
  }

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<PersistentResource>(context);
    final _options =
        SplayTreeMap<String, String>.from(options, (a, b) => a.compareTo(b));
    final instance = _typeToInstance(persistent);

    return PersistentWatcher(
      builder: (context, box, child) {
        return BaseDialog(
          dialogTitle: const Text('Filter Options'),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              for (String key in _options.keys)
                NotificationCheckBox(
                  option: _options[key],
                  optionKey: key,
                  value: instance[key],
                )
            ]),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('DISMISS'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class NotificationCheckBox extends StatelessWidget {
  const NotificationCheckBox(
      {Key key,
      @required this.option,
      @required this.optionKey,
      @required this.value})
      : assert(option != null),
        assert(optionKey != null),
        assert(value != null),
        super(key: key);

  final String option;
  final String optionKey;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<PersistentResource>(context);

    return CheckboxListTile(
      title: Text(option),
      value: value,
      activeColor: Theme.of(context).accentColor,
      onChanged: (b) async {
        // debugPrint(optionKey);
        storage.box.put(optionKey, b);
        await NotificationRepository.subscribeToNotification(optionKey, b);
      },
    );
  }
}
