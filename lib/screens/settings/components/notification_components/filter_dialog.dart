import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/dialogs/base_dialog.dart';

enum FilterType { acolytes, news, cycles, fissure }

class FilterDialog extends StatelessWidget with DialogWidget {
  FilterDialog({this.options, this.type});

  final Map<String, String> options;
  final FilterType type;

  static Future<void> showFilters(BuildContext context,
      Map<String, String> options, FilterType type) async {
    DialogWidget.openDialog(
        context, FilterDialog(options: options, type: type));
  }

  Map<String, bool> _typeToInstance(StorageState state) {
    switch (type) {
      case FilterType.acolytes:
        return state.acolytes;
        break;
      case FilterType.news:
        return state.news;
        break;
      case FilterType.cycles:
        return state.cycles;
        break;
      case FilterType.fissure:
        return <String, bool>{};
        break;
      default:
        return <String, bool>{};
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: BlocProvider.of<StorageBloc>(context),
      builder: (context, state) {
        final instance = _typeToInstance(state);

        return BaseDialog(
          dialogTitle: 'Filter Options',
          child: Column(children: <Widget>[
            for (String key in options.keys)
              CheckboxListTile(
                title: Text(options[key]),
                value: instance[key],
                activeColor: Theme.of(context).accentColor,
                onChanged: (b) => storage.dispatch(ToggleNotification(key, b)),
              )
          ]),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
