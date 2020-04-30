import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';

import '../../../utils/faction_utils.dart';

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({Key key, this.syndicate}) : super(key: key);

  final SyndicateFaction syndicate;

  IconData _getIcon() {
    switch (syndicate) {
      case SyndicateFaction.ostrons:
        return SyndicateGlyphs.ostron;
      case SyndicateFaction.solaris_united:
        return SyndicateGlyphs.solaris;
      case SyndicateFaction.nightwave:
        return SyndicateGlyphs.nightwave;
      default:
        return SyndicateGlyphs.simaris;
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthFactor = MediaQuery.of(context).size.width / 100;

    return Icon(
      _getIcon(),
      size: widthFactor * 12,
      color: syndicate.iconColor,
    );
  }
}
