import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

// SearchBar is 56dp https://m3.material.io/components/search/specs, this adds a bit of space below
const _appBarHeight = 64.0;

class ItemOverviewAppBar extends SliverPersistentHeaderDelegate {
  const ItemOverviewAppBar({
    required this.image,
    required this.name,
    this.description,
    this.releaseDate,
    this.wikiUrl,
    this.isMod = false,
    this.isVaulted = false,
    required this.expandedHeight,
  });

  final String image;
  final String name;
  final String? description;
  final String? releaseDate;
  final String? wikiUrl;
  final bool isMod;
  final bool isVaulted;
  final double expandedHeight;

  @override
  double get maxExtent => max(expandedHeight, _appBarHeight);

  @override
  double get minExtent => _appBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const duration = Durations.medium1;
    final height = shrinkOffset > 0.0 ? 0.0 : (expandedHeight / 100) * 75;
    final progress = shrinkOffset / maxExtent;

    return SizedBox(
      height: maxExtent,
      child: Column(
        // fit: StackFit.expand,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            elevation: 0,
            title: AnimatedOpacity(opacity: progress, duration: duration, child: Text(name)),
            leading: IconButton.filledTonal(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              if (isVaulted)
                TextButton(
                  onPressed: null,
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(context.theme.colorScheme.error)),
                  child: Text(context.l10n.codexVaultedLabel),
                ),
              if (wikiUrl != null)
                TextButton(onPressed: () => wikiUrl!.launchLink(context), child: Text(context.l10n.seeWiki)),
            ],
          ),
          if (!isMod)
            AnimatedOpacity(
              duration: duration,
              curve: Curves.easeOut,
              opacity: 1 - progress,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 8, // 8 is just a padding
                height: height,
                child: ItemOverview(
                  image: image,
                  name: name,
                  description: description,
                  releaseDate: releaseDate,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(ItemOverviewAppBar oldDelegate) {
    return oldDelegate.name != name ||
        oldDelegate.description != description ||
        oldDelegate.expandedHeight != expandedHeight ||
        oldDelegate.image != image;
  }
}

class ItemOverview extends StatelessWidget {
  const ItemOverview({
    super.key,
    required this.image,
    required this.name,
    this.description,
    this.releaseDate,
  });

  final String image;
  final String name;
  final String? description;
  final String? releaseDate;

  @override
  Widget build(BuildContext context) {
    const textAlpha = 160;
    const textAlignment = TextAlign.center;

    final colorScheme = context.theme.colorScheme;
    final release = releaseDate != null ? DateTime.parse(releaseDate!) : null;
    final format = MaterialLocalizations.of(context).formatCompactDate;

    return Card(
      color: colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CircleAvatar(
                    radius: constraints.maxHeight / 2,
                    backgroundColor: colorScheme.onSecondaryContainer,
                    foregroundImage: CachedNetworkImageProvider(image, maxWidth: constraints.maxWidth ~/ 2),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                title: Text(name, textAlign: textAlignment),
                subtitle: Text(description ?? '', textAlign: TextAlign.center),
                titleTextStyle: context.textTheme.titleMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                subtitleTextStyle: context.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withAlpha(textAlpha),
                ),
              ),
            ),
            if (release != null)
              Text(
                'Release Date ${format(release)}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withAlpha(textAlpha - 30),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
