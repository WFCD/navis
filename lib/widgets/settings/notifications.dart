import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/notification_filters.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/widgets/dialogs.dart';
import 'package:navis/widgets/widgets.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  void openDialog(BuildContext context, String type) {
    switch (type) {
      /*case 'Acolytes':
        FilterDialog.showFilters(context, acolytes, FilterType.acolytes);
        break;*/
      case 'Cycles':
        FilterDialog.showFilters(context, cycles, FilterType.cycles);
        break;
      case 'Resources':
        FilterDialog.showFilters(context, resources, FilterType.resources);
        break;
      /*case 'Fissure Missions':
        debugPrint('not implemented yet');
        break;*/
      case 'News':
        FilterDialog.showFilters(context, newsType, FilterType.news);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Notifications'),
        for (Map<String, String> m in simple)
          _SimpleNotification(
            name: m['name'],
            description: m['description'],
            optionKey: m['key'],
          ),
        for (String k in filtered.keys)
          ListTile(
            title: Text(k),
            subtitle: Text(filtered[k]),
            onTap: () => openDialog(context, k),
          ),
      ]),
    );
  }
}

class _SimpleNotification extends StatelessWidget {
  const _SimpleNotification({
    Key key,
    @required this.name,
    @required this.description,
    @required this.optionKey,
  }) : super(key: key);

  final String name;
  final String description;
  final String optionKey;

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<PersistentResource>(context);

    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: persistent.watchBox(), //persistent.hiveBox,
      builder: (context, box, child) {
        return CheckboxListTile(
          title: Text(name),
          subtitle: Text(description),
          value: persistent.simple[optionKey],
          activeColor: Theme.of(context).accentColor,
          onChanged: (b) {
            box.put(optionKey, b);
            NotificationRepository.subscribeToNotification(optionKey, b);
          },
        );
      },
    );
  }
}
