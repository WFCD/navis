import 'package:flutter/material.dart';
import 'package:navis_ui/src/helpers/helpers.dart';
import 'package:navis_ui/src/widgets/widgets.dart';

class SyndicateIcon extends StatelessWidget {
  const SyndicateIcon({
    super.key,
    required this.syndicate,
    this.iconSize,
    this.useSyndicateColor = true,
  });

  final Syndicates syndicate;
  final double? iconSize;
  final bool useSyndicateColor;

  @override
  Widget build(BuildContext context) {
    return AppIcon(
      syndicate.syndicateIcon,
      size: iconSize,
      color: useSyndicateColor ? syndicate.primaryColor : Colors.white,
    );
  }
}
