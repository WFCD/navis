import 'package:navis/blocs/bloc.dart';
import 'package:flutter/material.dart';

class DateformatSetting extends StatelessWidget {
  const DateformatSetting({Key key}) : super(key: key);

  Widget formatoption(BuildContext context, StorageBloc storage) {
    return BlocBuilder(
      bloc: storage,
      builder: (BuildContext context, StorageState storageState) {
        return ListTile(
            title: const Text('Change Dateformat'),
            onTap: () => _showdialog(context, storage));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    final title = Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 8.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Behavior',
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: 15))));

    return Container(
      child: Column(children: <Widget>[title, formatoption(context, storage)]),
    );
  }
}

Future<void> _showdialog(BuildContext context, StorageBloc storage) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: const Text('Select DateFormat'),
          content: Container(
              child: BlocBuilder(
                  bloc: storage,
                  builder: (_, StorageState state) {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: Formats.values.map((v) {
                          final String format = v.toString().split('.').last;

                          return RadioListTile(
                              title: Text(format),
                              value: v,
                              groupValue: state.dateFormat,
                              activeColor: Theme.of(context).accentColor,
                              onChanged: (value) {
                                storage.dispatch(ChangeDateFormat(v));
                                Navigator.of(context).pop();
                              });
                        }).toList());
                  })),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
  );
}
