import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:package_info/package_info.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:user_settings/user_settings.dart';

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
          onChanged: (b) =>
              context.read<UserSettingsNotifier>().setOptOut(value: b!),
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

  static const double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    final info = sl<PackageInfo>();

    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isDark = theme.brightness != Brightness.light;

    final aboutTextStyle = theme.textTheme.bodyText1;
    final linkStyle =
        theme.textTheme.bodyText1?.copyWith(color: theme.colorScheme.secondary);

    return AboutListTile(
      applicationIcon: const Icon(
        AppIcons.nightmare,
        size: 60,
        color: Color(0xFF1565C0),
      ),
      applicationName: 'Cephalon Navis',
      applicationVersion: info.version,
      aboutBoxChildren: <Widget>[
        SizedBoxSpacer.spacerHeight12,
        RichText(
          text: TextSpan(
            children: <TextSpan>[
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
            ],
          ),
        ),
        SizedBoxSpacer.spacerHeight12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(SimpleIcons.discord, color: Color(0xFF7289DA)),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => discordInvite.launchLink(context),
            ),
            SizedBoxSpacer.spacerHeight24,
            IconButton(
              icon: Icon(
                SimpleIcons.github,
                color: isDark ? Colors.white : const Color(0xFF181717),
              ),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => projectPage.launchLink(context),
            ),
            SizedBoxSpacer.spacerHeight24,
            IconButton(
              icon: const AppIcon(
                AppIcons.wfcdLogoColor,
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
