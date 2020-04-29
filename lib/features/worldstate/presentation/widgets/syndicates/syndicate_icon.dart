import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/utils/syndicates_utils.dart';

class GetSyndicateIcon extends StatelessWidget {
  const GetSyndicateIcon({
    Key key,
    this.syndicate,
    this.color,
    this.size,
  }) : super(key: key);

  final SyndicateFactions syndicate;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (syndicate) {
      case SyndicateFactions.ostrons:
        icon = SyndicateIcons.ostronsigil;
        break;
      case SyndicateFactions.solaris_united:
        icon = SyndicateIcons.solarisunited;
        break;
      case SyndicateFactions.nightwave:
        icon = SyndicateIcons.nightwavesyndicate;
        break;
    }

    return Icon(
      icon,
      size: size ?? 50.0,
      color: color ?? syndicate.syndicateIconColor(),
      textDirection: TextDirection.ltr,
    );
  }
}
