import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/widgets/common/resource_watcher.dart';

import 'base_dialog.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({Key key}) : super(key: key);

  static Future<void> showThemes(BuildContext context) async {
    showDialog(context: context, builder: (_) => const ThemePicker());
  }

  void _onChanged(BuildContext context, int value) {
    final per = RepositoryProvider.of<PersistentResource>(context);

    per.updateTheme(value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final per = RepositoryProvider.of<PersistentResource>(context);

    return PersistentWatcher(
      storageKey: SettingsKeys.theme,
      builder: (context, box, child) {
        final current = per.theme;
        final accentColor = Theme.of(context).accentColor;

        return BaseDialog(
          dialogTitle: const Text('Themes'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<Brightness>(
                title: const Text('Light'),
                value: Brightness.light,
                groupValue: current.brightness,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, b.index),
              ),
              RadioListTile<Brightness>(
                title: const Text('Dark'),
                value: Brightness.dark,
                groupValue: current.brightness,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, b.index),
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
