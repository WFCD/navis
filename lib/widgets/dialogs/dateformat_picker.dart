import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/utils/enums.dart';

import 'base_dialog.dart';

class DateFormatPicker extends StatelessWidget {
  static Future<void> selectDateformat(BuildContext context) async {
    showDialog(context: context, builder: (_) => DateFormatPicker());
  }

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<PersistentResource>(context);

    return BaseDialog(
        dialogTitle: const Text('Select Dateformat'),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          for (final v in Formats.values)
            DateFormatRadioListTile(
              value: v,
              groupValue: persistent.dateformat,
              onChanged: (value) {
                persistent.dateformat = value;
                Navigator.of(context).pop();
              },
            )
        ]),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]);
  }
}

class DateFormatRadioListTile extends StatelessWidget {
  const DateFormatRadioListTile({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  }) : super(key: key);

  final Formats value;
  final Formats groupValue;
  final ValueChanged<Formats> onChanged;

  @override
  Widget build(BuildContext context) {
    final String format = value.toString().split('.').last;

    return RadioListTile<Formats>(
      title: Text(format),
      value: value,
      groupValue: groupValue,
      activeColor: Theme.of(context).accentColor,
      onChanged: onChanged,
    );
  }
}
