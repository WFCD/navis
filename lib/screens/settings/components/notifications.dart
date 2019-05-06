import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/dialogs.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/notification_filters.dart';

class Notifications extends StatelessWidget {
  FilterType stringToFilter(String string) {
    switch (string) {
      case 'News':
        return FilterType.news;
      case 'Cycles':
        return FilterType.cycles;
      case 'Fissure Missions':
        return FilterType.missions;
      default:
        return FilterType.acolytes;
    }
  }

  bool getBool(String key, StorageState state) {
    switch (key) {
      case 'alerts':
        return state.alerts;
      case 'baro':
        return state.baro;
      case 'darvo':
        return state.darvo;
      default:
        return state.sorties;
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Notifications'),
        // basic notification types
        for (Map<String, String> m in simpleNotifications)
          BlocBuilder<ChangeEvent, StorageState>(
            bloc: storage,
            builder: (context, state) {
              return CheckboxListTile(
                  title: Text(m['name']),
                  subtitle: Text(m['description']),
                  value: getBool(m['key'], state),
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (b) =>
                      storage.dispatch(ToggleNotification(m['key'], b)));
            },
          ),

        // notification types with options
        for (String k in filteredNotifications.keys)
          ListTile(
            title: Text(k),
            subtitle: Text(filteredNotifications[k]),
            onTap: () =>
                ResourceFilterOptions.showFilters(context, stringToFilter(k)),
          )
      ]),
    );
  }
}
