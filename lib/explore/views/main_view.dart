import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExploreView();
  }
}

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSize = 30.0;
    final l10n = context.l10n;

    return Column(
      children: [
        AppCard(
          child: ListTile(
            leading: const Icon(Icons.map, size: iconSize),
            title: Text(l10n.mapTitle),
            subtitle: Text(l10n.mapDescription),
          ),
        ),
        AppCard(
          child: ListTile(
            leading: const Icon(WarframeSymbols.menu_FishLarge, size: iconSize),
            title: Text(l10n.fishTitle),
            subtitle: Text(l10n.fishDescription),
            onTap: () => Navigator.of(context).pushNamed('/fish'),
          ),
        ),
        AppCard(
          child: ListTile(
            leading: const Icon(Icons.search, size: iconSize),
            title: Text(l10n.codexTitle),
            subtitle: Text(l10n.codexDescription),
            onTap: () => Navigator.of(context).pushNamed('/codex'),
          ),
        ),
      ],
    );
  }
}
