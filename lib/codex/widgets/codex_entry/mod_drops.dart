import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

class ModDropLocations extends StatelessWidget {
  const ModDropLocations({super.key, required this.drops});

  final List<Drop> drops;

  @override
  Widget build(BuildContext context) {
    const decimalPoint = 100;
    final drops = List.of(this.drops)
      ..sort(
        (a, b) => ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100),
      );

    return Column(
      children: drops
          .map<Widget>(
            (e) => ListTile(
              title: Text(e.location),
              subtitle: e.chance != null
                  // Already being checked for null.
                  // ignore: avoid-non-null-assertion
                  ? Text('Drop chance ${e.chance! * decimalPoint}')
                  : null,
            ),
          )
          .toList(),
    );
  }
}
