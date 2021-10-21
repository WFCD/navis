import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

class ModDropLocations extends StatelessWidget {
  const ModDropLocations({Key? key, required this.drops}) : super(key: key);

  final List<Drop> drops;

  @override
  Widget build(BuildContext context) {
    final drops = List.of(this.drops)
      ..sort((a, b) => (b.chance! * 100).compareTo((a.chance! * 100)));

    return Column(
      children: drops
          .map<Widget>(
            (e) => ListTile(
              title: Text(e.location),
              subtitle: Text('Drop chance ${e.chance! * 100}'),
            ),
          )
          .toList(),
    );
  }
}
