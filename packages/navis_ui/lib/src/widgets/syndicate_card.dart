import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class SyndicateCard extends StatelessWidget {
  const SyndicateCard({
    super.key,
    required this.syndicate,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  final SyndicateFactions? syndicate;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    final titleStyle = textTheme.titleMedium
        ?.copyWith(color: Typography.whiteMountainView.titleMedium?.color);

    final faction = syndicate?.colorScheme ??
        DefaultColorScheme(
          iconColor: context.theme.colorScheme.secondary,
          backgroundColor: context.theme.colorScheme.primary,
        );

    return AppCard(
      color: faction.backgroundColor,
      child: InkWell(
        onTap: onTap,
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: (mediaQuery.size.longestSide / 100) * 1.5,
          ),
          child: ListTile(
            leading: AppIcon(
              faction.icon,
              size: 60,
              color: faction.iconColor,
            ),
            title: Text(syndicate?.name ?? 'TBA', style: titleStyle),
            subtitle: subtitle,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
