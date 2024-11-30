import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BasicItemInfo extends SliverPersistentHeaderDelegate {
  const BasicItemInfo({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.expandedHeight,
    this.disableInfo = false,
    this.wikiaUrl,
    this.isVaulted,
  });

  final String uniqueName;
  final String name;
  final String description;
  final String imageUrl;
  final String? wikiaUrl;
  final double expandedHeight;
  final bool? isVaulted;
  final bool disableInfo;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: 4,
      child: SizedBox(
        height: expandedHeight,
        child: Stack(
          children: <Widget>[
            AppBar(
              elevation: 0,
              iconTheme: context.theme.iconTheme,
              actions: [
                if (isVaulted ?? false)
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        context.theme.colorScheme.error,
                      ),
                    ),
                    onPressed: null,
                    child: Text(context.l10n.codexVaultedLabel),
                  ),
                if (wikiaUrl != null)
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        context.theme.textTheme.labelLarge?.color,
                      ),
                    ),
                    onPressed: () => wikiaUrl?.launchLink(context),
                    child: Text(context.l10n.seeWikia),
                  ),
              ],
            ),
            if (!disableInfo)
              Center(
                child: _EntryInfoContent(
                  height: expandedHeight,
                  shrinkOffset: shrinkOffset,
                  uniqueName: uniqueName,
                  imageUrl: imageUrl,
                  name: name,
                  description: description,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _EntryInfoContent extends StatelessWidget {
  const _EntryInfoContent({
    required this.height,
    required this.shrinkOffset,
    required this.uniqueName,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  final double shrinkOffset;
  final double height;
  final String uniqueName;
  final String imageUrl;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    const curve = Curves.easeOut;

    final mediaQuerySize = MediaQuery.of(context).size;

    final animatedContainerWidth = (mediaQuerySize.width / 100) * 95;
    final animatedContainerHeight =
        shrinkOffset > 0.0 ? 0.0 : (height / 100) * 90;

    return AnimatedOpacity(
      duration: kThemeAnimationDuration,
      curve: curve,
      opacity: 1 - (shrinkOffset / height),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        curve: curve,
        width: animatedContainerWidth,
        height: animatedContainerHeight,
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          child: EntryContent(
            uniqueName: uniqueName,
            name: name,
            description: description,
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}

class EntryContent extends StatelessWidget {
  const EntryContent({
    super.key,
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String uniqueName;
  final String name;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const textAlign = TextAlign.center;

    final textTheme = Theme.of(context).textTheme;
    final mediaQuerySize = MediaQuery.of(context).size;

    final imageContainerRadius = (mediaQuerySize.shortestSide / 100) * 8;
    final descriptionBoxWidth = (mediaQuerySize.width / 100) * 95;

    return ScreenTypeLayout.builder(
      mobile: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Hero(
                tag: uniqueName,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(imageUrl),
                  backgroundColor: Colors.grey,
                  radius: imageContainerRadius,
                ),
              ),
            ),
            Text(
              name,
              style: textTheme.titleMedium,
              textAlign: textAlign,
            ),
            SizedBox(
              width: descriptionBoxWidth,
              child: Text(
                description,
                style: textTheme.bodySmall,
                textAlign: textAlign,
              ),
            ),
          ],
        );
      },
      tablet: (_) {
        return SizedBox(
          width: descriptionBoxWidth,
          child: ListTile(
            leading: Hero(
              tag: uniqueName,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(imageUrl),
                backgroundColor: Colors.grey,
                radius: imageContainerRadius,
              ),
            ),
            title: Text(name),
            subtitle: Text(description),
          ),
        );
      },
    );
  }
}
