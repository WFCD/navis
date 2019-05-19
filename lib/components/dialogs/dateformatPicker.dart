import 'package:navis/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/enums.dart';

import 'base_dialog.dart';

class DateFormatPicker extends StatelessWidget with DialogWidget {
  static Future<void> selectDateformat(BuildContext context) async {
    DialogWidget.openDialog(context, DateFormatPicker());
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder(
        bloc: storage,
        builder: (BuildContext context, StorageState state) {
          return BaseDialog(
              dialogTitle: 'Select Dateformat',
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: Formats.values.map((v) {
                    final String format = v.toString().split('.').last;

                    return RadioListTile(
                        title: Text(format),
                        value: v,
                        groupValue: state.dateformat,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (value) {
                          storage.dispatch(ChangeDateFormat(v));
                          Navigator.of(context).pop();
                        });
                  }).toList()),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
        });
  }
}
