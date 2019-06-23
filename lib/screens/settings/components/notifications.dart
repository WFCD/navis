import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/screens/settings/components/notification_components/filter_dialog.dart';
import 'package:navis/utils/notification_filters.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  void openDialog(BuildContext context, String type) {
    switch (type) {
      case 'Acolytes':
        FilterDialog.showFilters(context, acolytes, FilterType.acolytes);
        break;
      case 'Cycles':
        FilterDialog.showFilters(context, cycles, FilterType.cycles);
        break;
      case 'Fissure Missions':
        debugPrint('not implemented yet');
        break;
      case 'News':
        FilterDialog.showFilters(context, newsType, FilterType.news);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return Container(
        child: Column(children: <Widget>[
      const SettingTitle(title: 'Notifications'),
      for (Map<String, String> m in simple)
        BlocBuilder<ChangeEvent, StorageState>(
            bloc: storage,
            builder: (context, state) {
              return CheckboxListTile(
                  title: Text(m['name']),
                  subtitle: Text(m['description']),
                  value: state.simple[m['key']],
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (b) =>
                      storage.dispatch(ToggleNotification(m['key'], b)));
            }),
      for (String k in filtered.keys)
        ListTile(
            title: Text(k),
            subtitle: Text(filtered[k]),
            onTap: () => openDialog(context, k)),
    ]));
  }
}
