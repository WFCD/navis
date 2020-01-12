import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/widgets/dialogs.dart';
import 'package:navis/widgets/widgets.dart';

class DisplayChoices extends StatelessWidget {
  const DisplayChoices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<PersistentResource>(context);

    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Behavior'),
        ListTile(
          title: const Text('Theme'),
          subtitle: const Text('Choose app theme.'),
          onTap: () => ThemePicker.showThemes(context),
        ),
        ListTile(
          title: const Text('Dateformat'),
          subtitle:
              const Text('Change the format used for timer expiration dates.'),
          onTap: () => DateFormatPicker.selectDateformat(context),
        ),
        ValueListenableBuilder<Box<dynamic>>(
          valueListenable: persistent.watchBox(key: SettingsKeys.backKey),
          builder: (context, box, child) {
            return CheckboxListTile(
              title: const Text('Back button opens drawer'),
              subtitle:
                  const Text('Pressing the back button opens the drawer.'),
              value: box.get('backkey', defaultValue: false),
              activeColor: Theme.of(context).accentColor,
              onChanged: (b) => box.put('backkey', b),
            );
          },
        )
      ]),
    );
  }
}
