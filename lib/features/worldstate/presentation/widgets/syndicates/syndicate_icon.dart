import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../utils/faction_utils.dart';

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({Key key, this.syndicate}) : super(key: key);

  final SyndicateFaction syndicate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return FaIcon(
      () {
        switch (syndicate) {
          case SyndicateFaction.cetus:
            return SyndicateGlyphs.ostron;
          case SyndicateFaction.solaris:
            return SyndicateGlyphs.solaris;
          case SyndicateFaction.entrati:
            return SyndicateGlyphs.entrati;
          case SyndicateFaction.nightwave:
            return SyndicateGlyphs.nightwave;
          case SyndicateFaction.cephalon_simaris:
            return SyndicateGlyphs.simaris;
          default:
            return NavisSysIcons.nightmare;
        }
      }(),
      size: getValueForScreenType(
          context: context,
          mobile: (mediaQuery.size.longestSide / 100) * 7,
          tablet: (mediaQuery.size.shortestSide / 100) * 8),
      color: syndicate.iconColor,
    );
  }
}
