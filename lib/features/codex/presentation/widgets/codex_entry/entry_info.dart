import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../l10n/l10n.dart';

double kMinExtent = (kToolbarHeight * 2) + 30;

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
    return Container(
      height: expandedHeight,
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            iconTheme: Theme.of(context).iconTheme,
            title: isMod ? Text(name) : null,
            actions: [
              if (isVaulted ?? false)
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Theme.of(context).errorColor),
                  ),
                  onPressed: null,
                  child:
                      Text(NavisLocalizations.of(context)!.codexVaultedLabel),
                ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).textTheme.button?.color),
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
            Align(alignment: Alignment.bottomCenter, child: bottom)
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kMinExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _EntryInfoContent extends StatelessWidget {
  const _EntryInfoContent({
    Key? key,
    required this.height,
    required this.shrinkOffset,
    required this.uniqueName,
    required this.imageUrl,
    required this.name,
    required this.description,
  }) : super(key: key);

  final double shrinkOffset, height;
  final String uniqueName;
  final String imageUrl;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    const textAlign = TextAlign.center;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedOpacity(
      duration: kThemeAnimationDuration,
      opacity: 1 - (shrinkOffset / height),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        width: (MediaQuery.of(context).size.width / 100) * 95,
        height: shrinkOffset > 0.0 ? 0 : (height / 100) * 90,
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
                    radius:
                        (MediaQuery.of(context).size.shortestSide / 100) * 8,
                  ),
                ),
              ),
              Text(
                name,
                style: textTheme.subtitle1,
                textAlign: textAlign,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width / 100) * 95,
                child: Text(
                  description,
                  style: textTheme.caption,
                  textAlign: textAlign,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
