import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/utils/helper_methods.dart';

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
            const SizedBox(height: 8.0),
            AppBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).canvasColor,
              iconTheme: Theme.of(context).iconTheme,
              brightness: Theme.of(context).brightness,
              actions: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color),
                  ),
                  onPressed: () => launchLink(context, wikiaUrl),
                  child: const Text('Seee wikia'),
                ),
              ],
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
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
