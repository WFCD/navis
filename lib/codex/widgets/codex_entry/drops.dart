import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

class DropLocations extends StatelessWidget {
  const DropLocations({super.key, required this.drops});

  final List<Drop> drops;

  @override
  Widget build(BuildContext context) {
    final drops = List.of(this.drops)
      ..sort(
        (a, b) => ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100),
      );

    return Column(
      children: drops
          .map<Widget>(
            (e) => _DropEntry(
              location: e.location,
              chance: e.chance ?? 0,
            ),
          )
          .toList(),
    );
  }
}

class _DropEntry extends StatelessWidget {
  const _DropEntry({required this.location, required this.chance});

  final String location;
  final double chance;

  @override
  Widget build(BuildContext context) {
    const decimalPoint = 100;
    final dropChance = (chance * decimalPoint).toStringAsFixed(2);

    return ListTile(
      title: Text(location),
      subtitle: Text('Drop chance $dropChance'),
    );
  }
}
