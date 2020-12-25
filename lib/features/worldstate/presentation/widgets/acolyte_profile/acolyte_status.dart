import 'package:flutter/material.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';

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

    final statTitle = Theme.of(context).textTheme.subtitle1;
    final statValue = Theme.of(context).textTheme.subtitle2;

    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RowItem(
            text: Text(context.locale.acolyteRank, style: statTitle),
            padding: padding,
            child: StaticBox.text(text: '$rank', style: statValue),
          ),
          RowItem(
            text: Text(context.locale.acolyteHealth, style: statTitle),
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
                  ? context.locale.acolyteCurrentLocation
                  : context.locale.acolytePassLocation,
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
                  ? context.locale.acolyteFound
                  : context.locale.acolyteLastSeen,
              style: statTitle,
            ),
            padding: padding,
            child: StaticBox.text(
              text: context.locale.acolyteElapsedTime(lastSeenTime),
              style: statValue,
            ),
          ),
        ],
      ),
    );
  }
}
