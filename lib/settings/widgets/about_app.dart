import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_icons/simple_icons.dart';

class AboutApp extends AbstractSettingsTile {
  const AboutApp({super.key, this.l10n});

  final NavisLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    const iconSize = 30.0;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final l10n = this.l10n ?? context.l10n;
    final isDark = theme.brightness != Brightness.light;

    final aboutTextStyle = textTheme.bodyLarge;
    final linkStyle =
        textTheme.bodyLarge?.copyWith(color: theme.colorScheme.secondary);

    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
        final info = snapshot.data;

        return AboutDialog(
          applicationIcon: const Icon(
            WarframeSymbols.nightmare,
            size: 50,
            color: Color(0xFF1565C0),
          ),
          applicationName: 'Cephalon Navis',
          applicationVersion: info?.version ?? '',
          children: <Widget>[
            Gaps.gap12,
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    style: aboutTextStyle,
                    text: '${l10n.sourceCode} \n',
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
                    text: '${l10n.issueTrackerTitle}\n\n',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => issuePage.launchLink(context),
                  ),
                  TextSpan(
                    text: 'Contribute translations\n',
                    style: aboutTextStyle,
                  ),
                  TextSpan(
                    text: contributeTranslations,
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => contributeTranslations.launchLink(context),
                  ),
                  TextSpan(
                    style: textTheme.bodySmall,
                    text: '\n\n${l10n.legalese}\n\n',
                  ),
                  TextSpan(
                    style: textTheme.bodySmall,
                    text: '${l10n.warframeLinkTitle}. \n',
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
            Gaps.gap12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    WarframeSymbols.wfcd,
                    color: Color(0xFF2e96ef),
                  ),
                  iconSize: iconSize,
                  splashColor: Colors.transparent,
                  onPressed: () => communityPage.launchLink(context),
                ),
                IconButton(
                  icon: Icon(
                    SimpleIcons.github,
                    color: isDark ? Colors.white : const Color(0xFF181717),
                  ),
                  iconSize: iconSize,
                  splashColor: Colors.transparent,
                  onPressed: () => projectPage.launchLink(context),
                ),
                IconButton(
                  icon: const Icon(
                    SimpleIcons.discord,
                    color: Color(0xFF7289DA),
                  ),
                  iconSize: iconSize,
                  splashColor: Colors.transparent,
                  onPressed: () => discordInvite.launchLink(context),
                ),
                if (!Platform.isIOS)
                  IconButton(
                    onPressed: () => buyMeCoffee.launchLink(context),
                    icon: const Icon(
                      SimpleIcons.buymeacoffee,
                      color: Color(0xFFFFDD00),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
