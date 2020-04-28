import 'package:flutter/material.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';

class AcolyteStatus extends StatelessWidget {
  const AcolyteStatus({
    Key key,
    @required this.health,
    @required this.rank,
    @required this.lastDiscoveredTime,
    @required this.location,
    this.isDiscovered = false,
  })  : assert(health != null),
        assert(rank != null),
        assert(lastDiscoveredTime != null),
        assert(location != null),
        super(key: key);

  final double health;
  final int rank;
  final String location;
  final DateTime lastDiscoveredTime;
  final bool isDiscovered;

  int get lastSeenTime =>
      lastDiscoveredTime.difference(DateTime.now()).inMinutes.abs();

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 4.0);

    final localizations = NavisLocalizations.of(context);
    final statTitle = Theme.of(context).textTheme.subtitle1;
    final statValue = Theme.of(context).textTheme.subtitle2;

    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RowItem(
            text: Text(localizations.acolyteRank, style: statTitle),
            padding: padding,
            child: StaticBox.text(text: '$rank', style: statValue),
          ),
          RowItem(
            text: Text(localizations.acolyteHealth, style: statTitle),
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
                  ? localizations.acolyteCurrentLocation
                  : localizations.acolytePassLocation,
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
              isDiscovered
                  ? localizations.acolyteFound
                  : localizations.acolyteLastSeen,
              style: statTitle,
            ),
            padding: padding,
            child: StaticBox.text(
              text: localizations.acolyteElapsedTime(lastSeenTime),
              style: statValue,
            ),
          ),
        ],
      ),
    );
  }
}
