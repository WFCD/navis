import 'package:flutter/material.dart';
import 'package:navis/core/widgets/custom_card.dart';
import 'package:navis/features/worldstate/presentation/pages/bounties.dart';
import 'package:navis/features/worldstate/presentation/pages/nightwaves.dart';
import 'package:navis/features/worldstate/utils/faction_utils.dart';
import 'package:worldstate_api_model/entities.dart';

import 'syndicate_icon.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    this.name,
    this.caption = 'Tap to see bounties',
    this.syndicate,
  })  : assert(caption != null),
        assert(
            name == null || syndicate == null,
            'If name is null then it will default\n'
            'to Syndicate.name instead');

  final String name, caption;

  /// [name] doesn't need to be applied if this is not null.
  final Syndicate syndicate;

  void onTap(BuildContext context) {
    final _syndicate = syndicateStringToEnum(name ?? syndicate.name);

    switch (_syndicate) {
      case SyndicateFaction.nightwave:
        Navigator.of(context).pushNamed(NightwavesPage.route);
        break;
      case SyndicateFaction.solaris_united:
        continue SYNDICATEJOBS;
        break;

      SYNDICATEJOBS:
      case SyndicateFaction.ostrons:
        Navigator.of(context)
            .pushNamed(BountiesPage.route, arguments: syndicate);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final syndicateName = syndicateStringToEnum(name ?? syndicate.name);

    final titleStyle = textTheme.subtitle1
        .copyWith(color: Typography.whiteMountainView.subtitle1.color);

    final captionStyle = textTheme.caption
        .copyWith(color: Typography.whiteMountainView.caption.color);

    return InkWell(
      onTap: () => onTap(context),
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: CustomCard(
        color: syndicateName.backgroundColor,
        child: ListTile(
          leading: GetSyndicateIcon(syndicate: syndicateName),
          title: Text(name ?? syndicate.name, style: titleStyle),
          subtitle: Text(caption, style: captionStyle),
        ),
      ),
    );
  }
}
