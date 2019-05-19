import 'package:flutter/material.dart';
import 'package:navis/components/dialogs.dart';
import 'package:navis/components/layout.dart';

class DateformatSetting extends StatelessWidget {
  const DateformatSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Behavior'),
        ListTile(
            title: const Text('Dateformat'),
            subtitle:
                const Text('Change the format used for timer expiration dates'),
            onTap: () => DateFormatPicker.selectDateformat(context))
      ]),
    );
  }
}
