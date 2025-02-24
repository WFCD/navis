import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DropLocations extends StatelessWidget {
  const DropLocations({super.key, required this.drops});

  final List<Drop> drops;

  int _sortDrops(Drop a, Drop b) {
    final chanceA = a.chance ?? 0;
    final chanceB = b.chance ?? 0;

    return (chanceB * 100).compareTo(chanceA * 100);
  }

  @override
  Widget build(BuildContext context) {
    final maxRange = drops.length < 4 ? drops.length : 4;
    drops.sort(_sortDrops);

    return AppCard(
      child: Column(
        children: drops.getRange(0, maxRange).map((e) => _DropEntry(location: e.location, chance: e.chance!)).toList(),
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

    return ListTile(title: Text(location), subtitle: Text(context.l10n.dropChance(dropChance)));
  }
}
