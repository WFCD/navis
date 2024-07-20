import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/gen/assets.gen.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    this.imageUrl,
    this.padding = EdgeInsets.zero,
    this.height = 150,
    required this.child,
  }) : super(key: key);

  final String? imageUrl;
  final EdgeInsetsGeometry padding;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return ImageContainer(
        imageProvider: Assets.derelict.provider(),
        padding: padding,
        child: const SizedBox(),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) {
        return ImageContainer(
          imageProvider: imageProvider,
          padding: padding,
          height: height,
          child: child,
        );
      },
      placeholder: (context, url) {
        return ImageContainer(
          imageProvider: Assets.derelict.provider(),
          padding: padding,
          height: height,
          child: child,
        );
      },
      errorWidget: (context, url, dynamic error) {
        return ImageContainer(
          imageProvider: Assets.derelict.provider(),
          padding: padding,
          height: height,
          child: child,
        );
      },
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    required this.imageProvider,
    required this.padding,
    this.height,
    required this.child,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final EdgeInsetsGeometry padding;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cacheHeight = 250 * MediaQuery.of(context).devicePixelRatio.toInt();

    return AnimatedContainer(
      height: height,
      duration: kThemeAnimationDuration,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(imageProvider, height: cacheHeight),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const <double>[0.3, 1],
              colors: <Color>[
                Colors.black.withOpacity(0.7),
                Colors.transparent
              ],
            ),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
