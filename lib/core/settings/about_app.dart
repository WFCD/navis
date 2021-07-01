import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:simple_icons/simple_icons.dart';

import '../../constants/links.dart';
import '../../injection_container.dart';
import '../../l10n/l10n.dart';
import '../notifiers/user_settings_notifier.dart';
import '../utils/helper_methods.dart';
import '../widgets/widgets.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: <Widget>[
        CategoryTitle(title: l10n.aboutCategoryTitle),
        CheckboxListTile(
          title: Text(l10n.optOutOfAnalyticsTitle),
          subtitle: Text(l10n.optOutOfAnalyticsDescription),
          value: context.watch<UserSettingsNotifier>().isOptOut,
          onChanged: (b) => context.read<UserSettingsNotifier>().setOptOut(b!),
        ),
        ListTile(
          title: Text(l10n.reportBugsTitle),
          subtitle: Text(l10n.reportBugsDescription),
          onTap: () => issuePage.launchLink(context),
        ),
        const About()
      ],
    );
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  static const double _iconSize = 30.0;

  @override
  Widget build(BuildContext context) {
    final info = sl<PackageInfo>();

    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isDark = theme.brightness != Brightness.light;

    final aboutTextStyle = theme.textTheme.bodyText1;
    final linkStyle =
        theme.textTheme.bodyText1?.copyWith(color: theme.accentColor);

    return AboutListTile(
      icon: null,
      applicationIcon: const Icon(
        NavisSysIcons.nightmare,
        size: 60,
        color: Color(0xFF1565C0),
      ),
      applicationName: 'Cephalon Navis',
      applicationVersion: info.version,
      aboutBoxChildren: <Widget>[
        const SizedBox(height: 12.0),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              style: aboutTextStyle,
              text: '${l10n.homePageTitle} ',
            ),
            TextSpan(
              text: projectPage,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => projectPage.launchLink(context),
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '\n\n${l10n.issueTrackerDescription} ',
            ),
            TextSpan(
              text: l10n.issueTrackerTitle,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => issuePage.launchLink(context),
            ),
            TextSpan(
              style: Theme.of(context).textTheme.caption,
              text: '\n\n${l10n.legalese}',
            ),
            TextSpan(
              style: Theme.of(context).textTheme.caption,
              text: '${l10n.warframeLinkTitle} ',
            ),
            TextSpan(
              text: warframePage,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => warframePage.launchLink(context),
            ),
          ]),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(SimpleIcons.discord, color: Color(0xFF7289DA)),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => discordInvite.launchLink(context),
            ),
            const SizedBox(width: 25),
            IconButton(
              icon: Icon(
                SimpleIcons.github,
                color: isDark ? Colors.white : const Color(0xFF181717),
              ),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => projectPage.launchLink(context),
            ),
            const SizedBox(width: 25),
            IconButton(
              icon: const FaIcon(
                NavisSysIcons.wfcdLogoColor,
                color: Color(0xFF2e96ef),
              ),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => communityPage.launchLink(context),
            )
          ],
        ),
      ],
    );
  }
}
