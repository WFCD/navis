import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/components/widgets.dart';
import 'package:navis/components/layout/setting_title.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/utils.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<Repository>(context).storageService;

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
