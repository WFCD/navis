import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/notification_filters.dart';
import 'package:navis/widgets/dialogs.dart';
import 'package:navis/widgets/widgets.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  void openDialog(BuildContext context, LocalizedFilter filters, String type) {
    switch (type) {
      case 'acolytes':
        FilterDialog.showFilters(
            context, filters.acolytes, FilterType.acolytes);
        break;
      case 'cycles':
        FilterDialog.showFilters(
            context, filters.planetCycles, FilterType.cycles);
        break;
      case 'resources':
        FilterDialog.showFilters(
            context, filters.resources, FilterType.resources);
        break;
      case 'fissures':
        FilterDialog.showFilters(
            context, filters.fissures, FilterType.fissures);
        break;
      case 'news':
        FilterDialog.showFilters(
            context, filters.warframeNews, FilterType.news);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = LocalizedFilter(NavisLocalizations.of(context));

    return Container(
      child: Column(children: <Widget>[
        const SettingTitle(title: 'Notifications'),
        for (Map<String, String> m in filters.simpleFilters)
          _SimpleNotification(
            name: m['name'],
            description: m['description'],
            optionKey: m['key'],
          ),
        for (Map<String, String> k in filters.filtered)
          ListTile(
            title: Text(k['title']),
            subtitle: Text(k['description']),
            onTap: () => openDialog(context, filters, k['type']),
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
    final persistent = RepositoryProvider.of<Repository>(context).persistent;
    final notification =
        RepositoryProvider.of<Repository>(context).notifications;

    return WatchBoxBuilder(
      box: persistent.hiveBox,
      builder: (BuildContext context, Box box) {
        return SwitchListTile(
          title: Text(name),
          subtitle: Text(description),
          value: persistent.getToggle(optionKey),
          activeColor: Theme.of(context).accentColor,
          onChanged: (b) {
            persistent.setToggle(optionKey, b);
            notification.subscribeToNotification(optionKey, b);
          },
        );
      },
    );
  }
}
