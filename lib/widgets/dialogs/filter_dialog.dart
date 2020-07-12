import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';

import 'base_dialog.dart';

enum FilterType { acolytes, news, cycles, resources, fissures }

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

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<Repository>(context).persistent;
    final _options =
        SplayTreeMap<String, String>.from(options, (a, b) => a.compareTo(b));

    return WatchBoxBuilder(
      box: persistent.hiveBox,
      watchKeys: options.keys.toList(),
      builder: (BuildContext context, Box box) {
        return BaseDialog(
          dialogTitle: const Text('Filter Options'),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              for (String key in _options.keys)
                NotificationCheckBox(
                  option: _options[key],
                  optionKey: key,
                  value: persistent.getToggle(key),
                )
            ]),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
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
        storage.hiveBox.put(optionKey, b);
        await firebase.subscribeToNotification(optionKey, b);
      },
    );
  }
}
