import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/constants/links.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/services/repository.dart';
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

    final updateStatus =
        await RepositoryProvider.of<Repository>(context).updateDropTable();

    if (updateStatus)
      _showSnackBar(context, 'Updated drop table');
    else
      _showSnackBar(context, 'Drop table is up-to-date');
  }

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);
    final repository = RepositoryProvider.of<Repository>(context);
    final date = _dateFormat.format(repository.cache.getDropTableTimestamp);

    return Column(
      children: <Widget>[
        SettingTitle(title: localizations.aboutCategoryTitle),
        ListTile(
          title: Text(localizations.updateDropTableTitle),
          subtitle: Text(localizations.updateDropTableDescription(date)),
          onTap: () => _updateTable(context),
        ),
        ListTile(
          title: Text(localizations.reportBugsTitle),
          subtitle: Text(localizations.reportBugsDescription),
          onTap: () => launchLink(issuePage),
        ),
        const About()
      ],
    );
  }
}
