import 'package:flutter/material.dart';
import 'package:navis/constants/links.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/utils/helper_utils.dart';
import 'package:navis/widgets/widgets.dart';

import 'about_widget.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Column(
      children: <Widget>[
        SettingTitle(title: localizations.aboutCategoryTitle),
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
