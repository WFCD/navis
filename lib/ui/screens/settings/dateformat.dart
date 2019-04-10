import 'package:navis/blocs/bloc.dart';
import 'package:flutter/material.dart';

import 'package:navis/ui/widgets/dialogs.dart';

class DateformatSetting extends StatelessWidget {
  const DateformatSetting({Key key}) : super(key: key);

  Widget formatoption(BuildContext context, StorageBloc storage) {
    return BlocBuilder(
      bloc: storage,
      builder: (BuildContext context, StorageState storageState) {
        return;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 10.0, left: 8.0),
            alignment: Alignment.centerLeft,
            child: Text('Behavior',
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: 15))),
        ListTile(
            title: const Text('Change Dateformat'),
            onTap: () => DateFormatPicker.selectDateformat(context))
      ]),
    );
  }
}
