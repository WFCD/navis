import 'package:flutter/material.dart';
import 'package:navis/core/utils/ui_util.dart';
import 'package:navis/core/widgets/custom_card.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/pages/bounties.dart';
import 'package:navis/features/worldstate/presentation/pages/nightwaves.dart';
import 'package:navis/features/worldstate/utils/faction_utils.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/entities.dart';

import 'syndicate_icon.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    this.name,
    this.caption,
    this.syndicate,
    this.onTap,
  }) : assert(
            name == null || syndicate == null,
            'If name is null then it will default\n'
            'to Syndicate.name instead');

  final String name, caption;

  /// [name] doesn't need to be applied if this is not null.
  final Syndicate syndicate;

  final void Function() onTap;

  void _onTap(BuildContext context) {
    final _syndicate = syndicateStringToEnum(name ?? syndicate.id);

    switch (_syndicate) {
      case SyndicateFaction.nightwave:
        Navigator.of(context).pushNamed(NightwavesPage.route);
        break;
      case SyndicateFaction.solaris:
        continue SYNDICATEJOBS;
        break;

      SYNDICATEJOBS:
      case SyndicateFaction.cetus:
        Navigator.of(context)
            .pushNamed(BountiesPage.route, arguments: syndicate);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final syndicateName = syndicateStringToEnum(name ?? syndicate.id);

    final titleStyle = textTheme.subtitle1
        .copyWith(color: Typography.whiteMountainView.subtitle1.color);

    final captionStyle = textTheme.caption
        .copyWith(color: Typography.whiteMountainView.caption.color);

    return ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizing) {
      return InkWell(
        onTap: onTap ?? () => _onTap(context),
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: CustomCard(
          color: syndicateName.backgroundColor,
          margin: EdgeInsets.symmetric(
            horizontal: sizing.widthMultiplier * .8,
            vertical: sizing.heightMultiplier * .8,
          ),
          child: ListTile(
            leading: GetSyndicateIcon(syndicate: syndicateName),
            title: Text(name ?? syndicate.name, style: titleStyle),
            subtitle: Text(
              caption ?? NavisLocalizations.of(context).tapForMoreDetails,
              style: captionStyle,
            ),
          ),
        ),
      );
    });
  }
}
