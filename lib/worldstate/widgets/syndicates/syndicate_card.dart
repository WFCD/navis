import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    super.key,
    required this.syndicate,
    this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  final Syndicates syndicate;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final titleStyle = textTheme.titleMedium?.copyWith(color: Typography.whiteMountainView.titleMedium?.color);
    final captionStyle = textTheme.bodySmall?.copyWith(color: Typography.whiteMountainView.bodySmall?.color);

    return InkWell(
      onTap: onTap,
      customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      child: AppCard(
        color: syndicate.secondryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: (size.longestSide / 100) * 1.5),
          child: ListTile(
            leading: SyndicateIcon(syndicate: syndicate, iconSize: 50),
            title: Text(title ?? toBeginningOfSentenceCase(syndicate.fullName) ?? syndicate.name, style: titleStyle),
            subtitle: Text(subtitle ?? context.l10n.tapForMoreDetails, style: captionStyle),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
