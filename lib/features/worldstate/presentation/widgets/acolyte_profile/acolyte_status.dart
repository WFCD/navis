import 'package:flutter/material.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/widgets.dart';

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
    final statTitle = Theme.of(context).textTheme.subhead;
    final statValue = Theme.of(context).textTheme.subtitle;

    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RowItem(
            text: Text('Acolyte level', style: statTitle),
            padding: padding,
            child: StaticBox.text(text: '$rank', style: statValue),
          ),
          RowItem(
            text: Text('Health', style: statTitle),
            padding: padding,
            child: StaticBox.text(
              text: '${health.toStringAsFixed(2)} %',
              color: healthColor(health),
              style: statValue,
            ),
          ),
          RowItem(
            text: Text(
              isDiscovered ? 'Current location' : 'Last seen location',
              style: statTitle,
            ),
            padding: padding,
            child: StaticBox.text(
              text: location,
              style: statValue,
            ),
          ),
          RowItem(
            text: Text(isDiscovered ? 'Found' : 'Last seen', style: statTitle),
            padding: padding,
            child: StaticBox.text(
              text: '$lastSeenTime\m ago',
              style: statValue,
            ),
          ),
        ],
      ),
    );
  }
}
