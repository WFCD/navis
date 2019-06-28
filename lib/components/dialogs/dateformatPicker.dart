import 'package:navis/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/enums.dart';

import 'base_dialog.dart';

class DateFormatPicker extends StatelessWidget {
  static Future<void> selectDateformat(BuildContext context) async {
    showDialog(context: context, builder: (_) => DateFormatPicker());
  }

  Widget _buildRadio(BuildContext context, StorageState state, Formats v,
      ValueChanged<dynamic> onChanged) {
    final String format = v.toString().split('.').last;

    return RadioListTile(
      title: Text(format),
      value: v,
      groupValue: state.dateformat,
      activeColor: Theme.of(context).accentColor,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder(
        bloc: storage,
        builder: (BuildContext context, StorageState state) {
          return BaseDialog(
              dialogTitle: 'Select Dateformat',
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                for (Formats v in Formats.values)
                  _buildRadio(context, state, v, (value) {
                    storage.dispatch(ChangeDateFormat(v));
                    Navigator.of(context).pop();
                  })
              ]),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
        });
  }
}
