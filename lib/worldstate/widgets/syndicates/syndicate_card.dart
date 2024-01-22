import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    super.key,
    required this.syndicateId,
    this.caption,
    this.trailing,
    required this.onTap,
  });

  final String syndicateId;
  final String? caption;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final syndicateName = syndicateStringToEnum(syndicateId);

    final titleStyle = textTheme.titleMedium
        ?.copyWith(color: Typography.whiteMountainView.titleMedium?.color);

    final captionStyle = textTheme.bodySmall
        ?.copyWith(color: Typography.whiteMountainView.bodySmall?.color);

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizing) {
        return InkWell(
          onTap: onTap,
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: AppCard(
            color: syndicateName.secondryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: (mediaQuery.size.longestSide / 100) * 1.5,
              ),
              child: ListTile(
                leading: SyndicateIcon(syndicate: syndicateName, iconSize: 50),
                title: Text(
                  toBeginningOfSentenceCase(syndicateName.name) ??
                      syndicateName.name,
                  style: titleStyle,
                ),
                subtitle: Text(
                  caption ?? context.l10n.tapForMoreDetails,
                  style: captionStyle,
                ),
                trailing: trailing,
              ),
            ),
          ),
        );
      },
    );
  }
}
