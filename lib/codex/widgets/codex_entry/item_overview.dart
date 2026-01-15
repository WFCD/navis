import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';

// SearchBar is 56dp https://m3.material.io/components/search/specs, this adds a bit of space below
const _appBarHeight = 64.0;

class ItemOverviewAppBar extends SliverPersistentHeaderDelegate {
  const ItemOverviewAppBar({
    required this.name,
    this.imageName,
    this.description,
    this.releaseDate,
    this.wikiUrl,
    this.isMod = false,
    this.isVaulted = false,
    required this.expandedHeight,
  });

  final String name;
  final String? imageName;
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
                  imageName: imageName,
                  name: name,
                  description: description,
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
        oldDelegate.imageName != imageName;
  }
}

class ItemOverview extends StatelessWidget {
  const ItemOverview({
    super.key,
    required this.name,
    this.imageName,
    this.description,
  });

  final String name;
  final String? imageName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Card(
      color: colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: .center,
          children: [
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CircleAvatar(
                    radius: constraints.maxHeight,
                    backgroundColor: colorScheme.onSecondaryContainer,
                    foregroundImage: CachedNetworkImageProvider(
                      imageName.warframeItemsCdn().optimize(
                        width: constraints.maxWidth ~/ 2,
                        pixelRatio: MediaQuery.devicePixelRatioOf(context),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              name,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (description != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  description!,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MinimalItemOverview extends StatelessWidget {
  const MinimalItemOverview({super.key, required this.name, this.imageName, this.description});

  final String name;
  final String? imageName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      children: [
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: constraints.maxHeight / 6,
                  backgroundColor: colorScheme.onSecondaryContainer,
                  foregroundImage: CachedNetworkImageProvider(
                    imageName.warframeItemsCdn().optimize(
                      width: constraints.maxWidth ~/ 2,
                      pixelRatio: MediaQuery.devicePixelRatioOf(context),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Text(name, style: context.textTheme.titleLarge, textAlign: .left),
              Gaps.gap8,
              if (description != null) Text(description!, textAlign: .left),
            ],
          ),
        ),
      ],
    );
  }
}
