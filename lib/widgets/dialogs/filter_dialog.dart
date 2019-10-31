import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';

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

  Map<String, bool> _typeToInstance(PersistentStorageService storage) {
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
    final persistent = RepositoryProvider.of<Repository>(context).persistent;

    return WatchBoxBuilder(
      box: persistent.hiveBox,
      watchKeys: options.keys.toList(),
      builder: (BuildContext context, Box box) {
        final instance = _typeToInstance(persistent);

        return BaseDialog(
          dialogTitle: const Text('Filter Options'),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              for (String key in options.keys)
                NotificationCheckBox(
                  option: options[key],
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
    final storage = RepositoryProvider.of<Repository>(context).persistent;
    final firebase = RepositoryProvider.of<Repository>(context).notifications;

    return CheckboxListTile(
      title: Text(option),
      value: value,
      activeColor: Theme.of(context).accentColor,
      onChanged: (b) async {
        // debugPrint(optionKey);
        storage.saveToDisk(optionKey, b);
        await firebase.subscribeToNotification(optionKey, b);
      },
    );
  }
}
