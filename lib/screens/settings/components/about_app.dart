import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/components/widgets.dart';
import 'package:navis/components/layout/setting_title.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/utils.dart';

class AboutApp extends StatelessWidget {
  AboutApp({Key key}) : super(key: key);

  final _dateFormat = DateFormat.yMMMMd('en_US').add_jms();

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<Repository>(context).storageService;
    final date = _dateFormat.format(storage.tableTimestamp);

    return Column(
      children: <Widget>[
        const SettingTitle(title: 'About'),
        ListTile(
          title: const Text('Drop Table'),
          subtitle: Text('Last updated $date'),
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
