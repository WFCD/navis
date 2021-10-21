import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../../utils/faction_utils.dart';
import '../../pages/bounties.dart';
import '../../pages/nightwaves.dart';
import 'syndicate_icon.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    Key? key,
    this.name,
    this.caption,
    this.syndicate,
    this.onTap,
  })  : assert(
          syndicate != null || name != null,
          'If name is null then it will default\n'
          'to Syndicate.id instead, only one can be null but not both',
        ),
        super(key: key);

  final String? name, caption;
  final Syndicate? syndicate;

  final void Function()? onTap;

  void _onTap(BuildContext context) {
    final _syndicate = syndicateStringToEnum(syndicate?.id ?? name!);

    if (_syndicate == SyndicateFaction.nightwave) {
      Navigator.of(context).pushNamed(NightwavesPage.route);
    } else {
      Navigator.of(context).pushNamed(BountiesPage.route, arguments: syndicate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final syndicateName = syndicateStringToEnum(syndicate?.id ?? name!);

    final titleStyle = textTheme.subtitle1
        ?.copyWith(color: Typography.whiteMountainView.subtitle1?.color);

    final captionStyle = textTheme.caption
        ?.copyWith(color: Typography.whiteMountainView.caption?.color);

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizing) {
        return InkWell(
          onTap: onTap ?? () => _onTap(context),
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: CustomCard(
            color: syndicateName.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: (mediaQuery.size.longestSide / 100) * 1.5,
              ),
              child: ListTile(
                leading: GetSyndicateIcon(syndicate: syndicateName),
                title: Text(
                  syndicate?.name.replaceFirst('Syndicate', '') ?? name!,
                  style: titleStyle,
                ),
                subtitle: Text(
                  caption ?? context.l10n.tapForMoreDetails,
                  style: captionStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
