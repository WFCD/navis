import 'package:flutter/material.dart';
import 'package:navis/utils/notification_filters.dart';
import 'package:navis/blocs/bloc.dart';

import 'base_dialog.dart';

enum FilterType { cycles, missions, news, acolytes }

class ResourceFilterOptions extends StatelessWidget with DialogWidget {
  const ResourceFilterOptions(this.option);

  final FilterType option;

  static Future<void> showFilters(
      BuildContext context, FilterType options) async {
    DialogWidget.openDialog(
        context,
        BlocBuilder(
            bloc: BlocProvider.of<StorageBloc>(context),
            builder: (context, state) => ResourceFilterOptions(options)));
  }

  void addFilters(List<Widget> children, StorageBloc bloc) {
    final MainStorageState state = bloc.currentState;
    final List<String> acos = acolytes['acolytes'];
    final List<String> missions = missionTypes['missions'];

    switch (option) {
      case FilterType.acolytes:
        children.addAll(acos.map((a) => Option(
              option: a,
              preferenceKey: acolytes['key'],
              enabled: state.getToggle(acolytes['key'], a),
            )));
        break;
      case FilterType.cycles:
        children.addAll(cycles.keys.map((c) => Option(
              option: c,
              preferenceKey: cycles[c],
              enabled: state.getToggle(cycles[c]),
            )));
        break;
      case FilterType.missions:
        children.addAll(missions.map((m) => Option(
              option: m,
              preferenceKey: missionTypes['key'],
              enabled: state.getToggle(missionTypes['key'], m),
            )));
        break;
      case FilterType.news:
        children.addAll(newsType.keys.map((n) => Option(
              option: n,
              preferenceKey: newsType[n],
              enabled: state.getToggle(newsType[n]),
            )));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    addFilters(children, BlocProvider.of<StorageBloc>(context));

    final missions =
        Container(height: 450, child: ListView(children: children));

    final simpleFilters = Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: children));

    return BaseDialog(
      dialogTitle: 'Filter Options',
      child: children.length > 6 ? missions : simpleFilters,
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('APPLY'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class Option extends StatelessWidget {
  const Option({this.option, this.preferenceKey, this.enabled = false});

  final String option;
  final String preferenceKey;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    void dispatcher(bool value) {
      if (preferenceKey == 'missions' || preferenceKey == 'acolytes') {
        storage.dispatch(ToggleNotification(preferenceKey, value, option));
      } else
        storage.dispatch(ToggleNotification(preferenceKey, value));
    }

    return CheckboxListTile(
        title: Text(option),
        value: enabled,
        activeColor: Theme.of(context).accentColor,
        onChanged: dispatcher);
  }
}
