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

    return chanceB.compareTo(chanceA);
  }

  @override
  Widget build(BuildContext context) {
    final maxRange = drops.length < 4 ? drops.length : 4;
    drops.sort(_sortDrops);

    return Column(
      children: [
        CategoryTitle(title: context.l10n.acquisitionCategoryTitle, contentPadding: EdgeInsets.zero),
        ...drops.getRange(0, maxRange).map((e) => _DropEntry(location: e.location, chance: e.chance!)),
      ],
    );
  }
}

class _DropEntry extends StatelessWidget {
  const _DropEntry({required this.location, required this.chance});

  final String location;
  final num chance;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(location),
      subtitle: Text(context.l10n.dropChance(chance)),
    );
  }
}
