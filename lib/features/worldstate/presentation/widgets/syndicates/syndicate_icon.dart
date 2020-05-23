import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';

import '../../../utils/faction_utils.dart';

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({Key key, this.syndicate}) : super(key: key);

  final SyndicateFaction syndicate;

  IconData _getIcon() {
    switch (syndicate) {
      case SyndicateFaction.cetus:
        return SyndicateGlyphs.ostron;
      case SyndicateFaction.solaris:
        return SyndicateGlyphs.solaris;
      case SyndicateFaction.nightwave:
        return SyndicateGlyphs.nightwave;
      case SyndicateFaction.cephalon_simaris:
        return SyndicateGlyphs.simaris;
      default:
        return NavisSysIcons.nightmare;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      _getIcon(),
      size: 50,
      color: syndicate.iconColor,
    );
  }
}
