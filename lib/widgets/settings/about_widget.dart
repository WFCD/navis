import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:navis/constants/links.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/helper_utils.dart';
import 'package:navis/widgets/common/fa_icon.dart';
import 'package:navis/widgets/icons.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  static const double _iconSize = 30.0;

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);
    final info = RepositoryProvider.of<Repository>(context).packageInfo;

    final theme = Theme.of(context);
    final isDark = theme.brightness != Brightness.light;

    final aboutTextStyle = theme.textTheme.bodyText1;
    final linkStyle =
        theme.textTheme.bodyText1.copyWith(color: theme.accentColor);

    return AboutListTile(
      icon: null,
      applicationIcon: const Icon(
        AppIcons.nightmare,
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
              text: '${localizations.homePageTitle} ',
            ),
            _LinkTextSpan(
              style: linkStyle,
              url: projectPage,
              text: projectPage,
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '\n\n${localizations.issueTrackerDescription} ',
            ),
            _LinkTextSpan(
              style: linkStyle,
              url: issuePage,
              text: localizations.issueTrackerTitle,
            ),
            TextSpan(
              style: Theme.of(context).textTheme.caption,
              text: '\n\n${localizations.legalese}',
            ),
            TextSpan(
              style: Theme.of(context).textTheme.caption,
              text: '${localizations.warframeLinkTitle} ',
            ),
            _LinkTextSpan(
              style: linkStyle,
              url: warframePage,
              text: warframePage,
            )
          ]),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(BrandIcons.discord, color: Color(0xFF7289DA)),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => launchLink(discordInvite),
            ),
            const SizedBox(width: 25),
            IconButton(
              icon: Icon(
                BrandIcons.github,
                color: isDark ? Colors.white : const Color(0xFF181717),
              ),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => launchLink(projectPage),
            ),
            const SizedBox(width: 25),
            IconButton(
              icon: const FaIcon(AppIcons.wfcd, color: Color(0xFF2e96ef)),
              iconSize: _iconSize,
              splashColor: Colors.transparent,
              onPressed: () => launchLink(communityPage),
            )
          ],
        ),
      ],
    );
  }
}

class _LinkTextSpan extends TextSpan {
  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()..onTap = () => launchLink(url));
}
