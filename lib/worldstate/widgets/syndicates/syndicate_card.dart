import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    super.key,
    this.name,
    this.caption,
    this.syndicate,
    this.nightwave,
    this.onTap,
  }) : assert(
          syndicate != null || name != null,
          'If name is null then it will default\n'
          'to Syndicate.id instead, only one can be null but not both',
        );

  final String? name;
  final String? caption;
  final Syndicate? syndicate;
  final Nightwave? nightwave;

  final void Function()? onTap;

  void _onTap(BuildContext context) {
    final syndicateEnum = syndicateStringToEnum(syndicate?.id ?? name ?? '');

    if (syndicateEnum == Syndicates.nightwave) {
      Navigator.of(context)
          .pushNamed(NightwavesPage.route, arguments: nightwave);
    } else {
      Navigator.of(context).pushNamed(BountiesPage.route, arguments: syndicate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final syndicateName = syndicateStringToEnum(syndicate?.id ?? name ?? '');

    final titleStyle = textTheme.titleMedium
        ?.copyWith(color: Typography.whiteMountainView.titleMedium?.color);

    final captionStyle = textTheme.bodySmall
        ?.copyWith(color: Typography.whiteMountainView.bodySmall?.color);

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizing) {
        return InkWell(
          onTap: onTap ?? () => _onTap(context),
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: AppCard(
            color: syndicateName.secondryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                // It's what worked for the style.
                // ignore: no-magic-number
                vertical: (mediaQuery.size.longestSide / 100) * 1.5,
              ),
              child: ListTile(
                // It's what worked for the style.
                // ignore: no-magic-number
                leading: SyndicateIcon(syndicate: syndicateName, iconSize: 50),
                title: Text(
                  syndicate?.name.replaceFirst('Syndicate', '') ?? name ?? '',
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
