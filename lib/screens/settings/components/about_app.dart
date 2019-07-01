import 'package:flutter/material.dart';
import 'package:navis/components/widgets.dart';
import 'package:navis/components/layout/setting_title.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/utils/link_handler.dart';

class AboutApp extends StatelessWidget {
  AboutApp({Key key}) : super(key: key);

  final storage = locator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SettingTitle(title: 'About'),
        ListTile(
          title: const Text('Update Drop Table'),
          subtitle: Text('Last updated ' + storage.tableTimestamp.toString()),
        ),
        ListTile(
          title: const Text('Report Issues'),
          subtitle: const Text('Report bugs or Request a feature'),
          onTap: () =>
              launchLink(context, 'https://github.com/WFCD/navis/issues'),
        ),
        const About()
      ],
    );
  }
}
