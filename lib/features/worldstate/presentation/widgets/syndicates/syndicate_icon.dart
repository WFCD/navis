import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../utils/faction_utils.dart';

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({Key? key, required this.syndicate}) : super(key: key);

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
          case SyndicateFaction.cephalonSimaris:
            return SyndicateGlyphs.simaris;
          case SyndicateFaction.unknown:
            return NavisSysIcons.nightmare;
        }
      }(),
      size: getValueForScreenType(
        context: context,
        mobile: (mediaQuery.size.longestSide / 100) * 7,
        tablet: (mediaQuery.size.shortestSide / 100) * 8,
      ),
      color: syndicate.iconColor,
    );
  }
}
