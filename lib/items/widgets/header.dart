import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

// SearchBar is 56dp https://m3.material.io/components/search/specs, this adds a bit of space below
const _appBarHeight = 64.0;

class ItemHeaderAppBar extends SliverPersistentHeaderDelegate {
  const ItemHeaderAppBar({
    required this.item,
    required this.expandedHeight,
    this.pinTitle = false,
    this.isVaulted = false,
  });

  final WarframeItem item;
  final double expandedHeight;
  final bool isVaulted;
  final bool pinTitle;

  @override
  double get maxExtent => max(expandedHeight, _appBarHeight);

  @override
  double get minExtent => _appBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const duration = Durations.medium1;

    final isMod = item.type.name.contains('mod');
    final wikiaUrl = item.wikiaUrl;
    final height = shrinkOffset > 0.0 ? 0.0 : (expandedHeight / 100) * 75;
    final progress = shrinkOffset / maxExtent;
    final title = Text(item.name);

    return SizedBox(
      height: maxExtent,
      child: Column(
        // fit: StackFit.expand,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            elevation: 0,
            title: pinTitle ? title : AnimatedOpacity(opacity: progress, duration: duration, child: title),
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
              if (wikiaUrl != null)
                TextButton(onPressed: () => wikiaUrl.launchLink(context), child: Text(context.l10n.seeWiki)),
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
                child: ItemHeader(
                  name: item.name,
                  imageName: item.imageName,
                  description: item.description,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(ItemHeaderAppBar oldDelegate) {
    return oldDelegate.item != item;
  }
}

class ItemHeader extends StatelessWidget {
  const ItemHeader({
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
            Flexible(child: ItemAvatar(imageName: imageName)),
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

class ItemAvatar extends StatelessWidget {
  const ItemAvatar({super.key, required this.imageName});

  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = min(constraints.maxWidth, constraints.maxHeight) / 2;
        final diameter = radius * 2;

        return CircleAvatar(
          radius: radius,
          backgroundColor: context.colorScheme.onSecondaryContainer,
          foregroundImage: CachedNetworkImageProvider(
            imageName.warframeItemsCdn().optimize(
              width: (diameter * MediaQuery.devicePixelRatioOf(context)).round(),
              pixelRatio: MediaQuery.devicePixelRatioOf(context),
            ),
          ),
        );
      },
    );
  }
}
