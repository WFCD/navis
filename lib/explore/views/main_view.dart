import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';

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
        // AppCard(
        //   child: ListTile(
        //     leading: const Icon(Icons.map, size: iconSize),
        //     title: Text(l10n.mapTitle),
        //     subtitle: Text(l10n.mapDescription),
        //   ),
        // ),
        AppCard(
          child: ListTile(
            leading: const Icon(WarframeIcons.menuFishLarge, size: iconSize),
            title: Text(l10n.fishTitle),
            subtitle: Text(l10n.fishDescription),
            onTap: () => const FishPageRoute().push<void>(context),
          ),
        ),
      ],
    );
  }
}
