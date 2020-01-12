import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/resources/storage/cache.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/utils/helper_utils.dart';
import 'package:navis/widgets/widgets.dart';

import 'about_widget.dart';

class AboutApp extends StatelessWidget {
  AboutApp({Key key}) : super(key: key);

  final _dateFormat = DateFormat.yMMMMd('en_US').add_jms();

  void _showSnackBar(BuildContext context, String content) {
    settings.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  Future<void> _updateTable(BuildContext context) async {
    _showSnackBar(context, 'Updating drop table');

    final cache = RepositoryProvider.of<CacheResource>(context);

    final updatedTimestamp =
        await RepositoryProvider.of<DropTableRepository>(context)
            .updateDrops(cache.getDropTableTimestamp);

    if (updatedTimestamp != cache.getDropTableTimestamp) {
      _showSnackBar(context, 'Updated drop table');
      cache.saveDropTableTimestamp(updatedTimestamp);
    } else {
      _showSnackBar(context, 'Drop table is up-to-date');
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = _dateFormat.format(DateTime.now());

    return Column(
      children: <Widget>[
        const SettingTitle(title: 'About'),
        ListTile(
          title: const Text('Update Drop Table'),
          subtitle: Text('Last updated $date'),
          onTap: () => _updateTable(context),
        ),
        ListTile(
          title: const Text('Report Issues'),
          subtitle: const Text('Report bugs or Request a feature'),
          onTap: () => launchLink('https://github.com/WFCD/navis/issues'),
        ),
        const About()
      ],
    );
  }
}
