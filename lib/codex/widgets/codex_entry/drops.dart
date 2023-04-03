import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DropLocations extends StatelessWidget {
  const DropLocations({super.key, required this.drops});

  final List<Drop> drops;

  int _sortDrops(Drop a, Drop b) {
    return ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100);
  }

  @override
  Widget build(BuildContext context) {
    final maxRange = this.drops.length > 4 ? 4 : this.drops.length;
    final drops = List.of(this.drops.getRange(0, maxRange))..sort(_sortDrops);

    return AppCard(
      child: Column(
        children: drops
            .map((e) => _DropEntry(location: e.location, chance: e.chance!))
            .toList(),
      ),
    );
  }
}

class _DropEntry extends StatelessWidget {
  const _DropEntry({required this.location, required this.chance});

  final String location;
  final num chance;

  @override
  Widget build(BuildContext context) {
    const decimalPoint = 100;
    final dropChance = (chance * decimalPoint).toStringAsFixed(2);

    return ListTile(
      title: Text(location),
      subtitle: Text('Drop chance $dropChance%'),
    );
  }
}
