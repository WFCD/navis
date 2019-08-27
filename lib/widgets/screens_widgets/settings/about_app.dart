import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/widgets/widgets.dart';

import 'about_widget.dart';

class AboutApp extends StatelessWidget {
  AboutApp({Key key}) : super(key: key);

  final _dateFormat = DateFormat.yMMMMd('en_US').add_jms();

  void _showSnackBar(String content) {
    settings.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<Repository>(context);
    final date = _dateFormat.format(repository.storageService.tableTimestamp);

    return Column(
      children: <Widget>[
        const SettingTitle(title: 'About'),
        ListTile(
          title: const Text('Update Drop Table'),
          subtitle: Text('Last updated $date'),
          onTap: () async {
            _showSnackBar('Updating drop table');
            final updateStatus = await repository.updateDropTable();

            if (updateStatus)
              _showSnackBar('Updated drop table');
            else
              _showSnackBar('Drop table is up-to-date');
          },
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
