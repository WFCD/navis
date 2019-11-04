import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/widgets/icons.dart';
import 'package:package_info/package_info.dart';

const _legalese = 'Warframe and the Warframe logo are registered trademarks '
    'of Digital Extremes Ltd. Cephalon Navis nor WFCD are '
    'affiliated with Digital Extremes Ltd. in any way.';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PackageInfo info =
        RepositoryProvider.of<Repository>(context).packageInfo;

    final ThemeData theme = Theme.of(context);
    final TextStyle aboutTextStyle = theme.textTheme.body2;
    final TextStyle linkStyle =
        theme.textTheme.body2.copyWith(color: theme.accentColor);

    return AboutListTile(
      icon: null,
      applicationIcon: Icon(
        AppIcons.nightmare,
        size: SizeConfig.imageSizeMultiplier * 10,
        color: const Color.fromRGBO(26, 80, 144, .9),
      ),
      applicationName: 'Cephalon Navis',
      applicationVersion: info.version,
      aboutBoxChildren: <Widget>[
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(style: aboutTextStyle, text: 'Homepage: '),
            _LinkTextSpan(
              context: context,
              style: linkStyle,
              url: 'https://github.com/WFCD/navis',
              text: 'https://github.com/WFCD/navis',
            ),
            TextSpan(
              style: aboutTextStyle,
              text: '\n\nReport issues or feature request to this prject\'s ',
            ),
            _LinkTextSpan(
              context: context,
              style: linkStyle,
              url: 'https://github.com/WFCD/navis/issues',
              text: 'issues tracker',
            ),
            TextSpan(
              style: aboutTextStyle,
              text:
                  '\n\nMore information on Warframe can be found on their official site\n',
            ),
            _LinkTextSpan(
              context: context,
              style: linkStyle,
              url: 'https://www.warframe.com/',
              text: 'https://www.warframe.com/',
            )
          ]),
        ),
        const SizedBox(height: 24),
        SvgPicture.asset('assets/wfcd_banner.svg', height: 50),
        const SizedBox(height: 16),
        Text(_legalese, style: Theme.of(context).textTheme.caption),
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

  _LinkTextSpan(
      {BuildContext context, TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchLink(context, url);
              });
}
