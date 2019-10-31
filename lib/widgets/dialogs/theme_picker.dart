import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/repository.dart';

import 'base_dialog.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({Key key}) : super(key: key);

  static Future<void> showThemes(BuildContext context) async {
    showDialog(context: context, builder: (_) => const ThemePicker());
  }

  void _onChanged(BuildContext context, Box box, int value) {
    box.put(SettingsKeys.theme, value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: RepositoryProvider.of<Repository>(context).persistent.hiveBox,
      builder: (BuildContext context, Box box) {
        final current = box.get(SettingsKeys.theme, defaultValue: 0);
        final accentColor = Theme.of(context).accentColor;

        return BaseDialog(
          dialogTitle: const Text('Themes'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<int>(
                title: const Text('Light'),
                value: 0,
                groupValue: current,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, box, b),
              ),
              RadioListTile<int>(
                title: const Text('Dark'),
                value: 1,
                groupValue: current,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, box, b),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
