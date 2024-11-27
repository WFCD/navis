import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/gen/assets.gen.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    this.imageUrl,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.bottomCenter,
    this.height = 150,
    required this.child,
  });

  final String? imageUrl;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
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

    return SizedBox(
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) {
          return ImageContainer(
            imageProvider: imageProvider,
            padding: padding,
            height: height,
            alignment: alignment,
            child: child,
          );
        },
        placeholder: (context, url) {
          return ImageContainer(
            imageProvider: Assets.derelict.provider(),
            padding: padding,
            height: height,
            alignment: alignment,
            child: child,
          );
        },
        errorWidget: (context, url, dynamic error) {
          return ImageContainer(
            imageProvider: Assets.derelict.provider(),
            padding: padding,
            alignment: alignment,
            height: height,
            child: child,
          );
        },
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imageProvider,
    required this.padding,
    this.alignment = Alignment.bottomCenter,
    this.height,
    required this.child,
  });

  final ImageProvider imageProvider;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          height: height,
          duration: kThemeAnimationDuration,
          alignment: alignment,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                imageProvider,
                height: constraints.maxHeight.toInt(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(padding: padding, child: child),
        );
      },
    );
  }
}
