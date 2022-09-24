import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

const kMinExtent = kToolbarHeight + kTextTabBarHeight;

class BasicItemInfo extends SliverPersistentHeaderDelegate {
  const BasicItemInfo({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.wikiaUrl,
    this.bottom,
    required this.expandedHeight,
    this.isMod = false,
    this.isVaulted,
  });

  final String uniqueName;
  final String name;
  final String description;
  final String imageUrl;
  final String? wikiaUrl;
  final Widget? bottom;
  final double expandedHeight;
  final bool isMod;
  final bool? isVaulted;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final canvasColor = context.theme.canvasColor;

    return Container(
      height: expandedHeight,
      color: canvasColor,
      child: Stack(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: canvasColor,
            iconTheme: context.theme.iconTheme,
            title: isMod ? Text(name) : null,
            actions: [
              if (isVaulted ?? false)
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(context.theme.errorColor),
                  ),
                  onPressed: null,
                  child: Text(context.l10n.codexVaultedLabel),
                ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    context.theme.textTheme.button?.color,
                  ),
                ),
                onPressed: () => wikiaUrl?.launchLink(context),
                child: Text(context.l10n.seeWikia),
              ),
            ],
          ),
          if (!isMod)
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
          if (bottom != null)
            Align(alignment: Alignment.bottomCenter, child: bottom),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + kTextTabBarHeight;

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

  final double shrinkOffset, height;
  final String uniqueName;
  final String imageUrl;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    const textAlign = TextAlign.center;
    final textTheme = Theme.of(context).textTheme;
    final mediaQuerySize = MediaQuery.of(context).size;

    final animatedContainerWidth = (mediaQuerySize.width / 100) * 95;
    final animatedContainerHeight =
        shrinkOffset > 0.0 ? 0.0 : (height / 100) * 90;

    final imageContainerRadius = (mediaQuerySize.shortestSide / 100) * 8;
    final descriptionBoxWidth = (mediaQuerySize.width / 100) * 95;

    return AnimatedOpacity(
      duration: kThemeAnimationDuration,
      opacity: 1 - (shrinkOffset / height),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        width: animatedContainerWidth,
        height: animatedContainerHeight,
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          child: Column(
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
                style: textTheme.subtitle1,
                textAlign: textAlign,
              ),
              SizedBox(
                width: descriptionBoxWidth,
                child: Text(
                  description,
                  style: textTheme.caption,
                  textAlign: textAlign,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
