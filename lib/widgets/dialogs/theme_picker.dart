import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/generated/l10n.dart';
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
    final localizations = NavisLocalizations.of(context);

    return WatchBoxBuilder(
      box: RepositoryProvider.of<Repository>(context).persistent.hiveBox,
      builder: (BuildContext context, Box box) {
        final current = box.get(SettingsKeys.theme, defaultValue: 2);
        final accentColor = Theme.of(context).accentColor;

        return BaseDialog(
          dialogTitle: Text(localizations.themeTitle),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<int>(
                title: Text(localizations.lightThemeTitle),
                value: 0,
                groupValue: current,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, box, b),
              ),
              RadioListTile<int>(
                title: Text(localizations.darkThemeTitle),
                value: 1,
                groupValue: current,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, box, b),
              ),
              RadioListTile<int>(
                title: Text(localizations.systemThemeTitle),
                value: 2,
                groupValue: current,
                activeColor: accentColor,
                onChanged: (b) => _onChanged(context, box, b),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
