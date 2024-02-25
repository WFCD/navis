import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/gen/assets.gen.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    this.imageUrl,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  final String? imageUrl;
  final EdgeInsetsGeometry padding;
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
      height: 350,
      width: 150,
      imageBuilder: (context, imageProvider) {
        return ImageContainer(
          imageProvider: imageProvider,
          padding: padding,
          child: child,
        );
      },
      placeholder: (context, url) {
        return ImageContainer(
          imageProvider: Assets.derelict.provider(),
          padding: padding,
          child: child,
        );
      },
      errorWidget: (context, url, dynamic error) {
        return ImageContainer(
          imageProvider: Assets.derelict.provider(),
          padding: padding,
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
    required this.child,
  }) : super(key: key);

  final ImageProvider imageProvider;

  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const <double>[0.3, 1],
            colors: <Color>[Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
