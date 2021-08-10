import 'package:flutter/material.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';

class AcolyteStatus extends StatelessWidget {
  const AcolyteStatus({
    Key? key,
    required this.health,
    required this.rank,
    required this.lastDiscoveredTime,
    required this.location,
    this.isDiscovered = false,
  }) : super(key: key);

  final double health;
  final int rank;
  final String location;
  final DateTime lastDiscoveredTime;
  final bool isDiscovered;

  int get lastSeenTime =>
      lastDiscoveredTime.difference(DateTime.now()).inMinutes.abs();

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 4);

    final l10n = context.l10n;
    final statTitle = Theme.of(context).textTheme.subtitle1;
    final statValue = Theme.of(context).textTheme.subtitle2;

    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RowItem(
            text: Text(l10n.acolyteRank, style: statTitle),
            padding: padding,
            child: StaticBox.text(text: '$rank', style: statValue),
          ),
          RowItem(
            text: Text(l10n.acolyteHealth, style: statTitle),
            padding: padding,
            child: StaticBox.text(
              text: '${health.toStringAsFixed(2)} %',
              color: healthColor(health),
              style: statValue,
            ),
          ),
          RowItem(
            text: Text(
              isDiscovered
                  ? l10n.acolyteCurrentLocation
                  : l10n.acolytePassLocation,
              style: statTitle,
            ),
            padding: padding,
            child: StaticBox.text(
              text: location,
              style: statValue,
            ),
          ),
          RowItem(
            text: Text(
              isDiscovered ? l10n.acolyteFound : l10n.acolyteLastSeen,
              style: statTitle,
            ),
            padding: padding,
            child: StaticBox.text(
              text: l10n.acolyteElapsedTime(lastSeenTime),
              style: statValue,
            ),
          ),
        ],
      ),
    );
  }
}
