import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BasicItemInfo extends SliverPersistentHeaderDelegate {
  const BasicItemInfo({
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    this.wikiaUrl,
    @required this.expandedHeight,
  });

  final String name;
  final String description;
  final String imageUrl;
  final String wikiaUrl;
  final double expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const textAlign = TextAlign.center;
    final textTheme = Theme.of(context)?.textTheme;

    return Container(
      height: expandedHeight,
      color: Theme.of(context).canvasColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Material(
                elevation: 1.0,
                child: Container(
                  height: kToolbarHeight,
                  child: const NavigationToolbar(leading: BackButton()),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: kThemeAnimationDuration,
              opacity: 1 - (shrinkOffset / expandedHeight),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(imageUrl),
                      backgroundColor: Colors.grey,
                      radius: ((MediaQuery.of(context).size.longestSide ?? 0) /
                              100) *
                          7,
                    ),
                  ),
                  Text(name, style: textTheme?.subtitle1, textAlign: textAlign),
                  Text(description,
                      style: textTheme?.caption, textAlign: textAlign)
                ],
              ),
            )
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
