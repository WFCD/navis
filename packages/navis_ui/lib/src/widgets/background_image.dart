import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    this.imageUrl,
    this.height,
    this.padding = EdgeInsets.zero,
    this.child,
  }) : super(key: key);

  final String? imageUrl;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  static const _derelict = AssetImage('assets/Derelict.webp');

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _ImageContainer(
        imageProvider: _derelict,
        height: height,
        padding: padding,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      height: height,
      width: 250,
      imageBuilder: (context, imageProvider) {
        return _ImageContainer(
          imageProvider: imageProvider,
          height: height,
          padding: padding,
          child: child,
        );
      },
      placeholder: (context, url) {
        return _ImageContainer(
          imageProvider: _derelict,
          height: height,
          padding: padding,
          child: child,
        );
      },
      errorWidget: (context, url, dynamic error) {
        return _ImageContainer(
          imageProvider: _derelict,
          height: height,
          padding: padding,
          child: child,
        );
      },
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    Key? key,
    required this.imageProvider,
    required this.height,
    required this.padding,
    this.child,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const blur = 1.0;

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Image(
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.dstIn,
              image: imageProvider,
            ),
          ),
          if (child != null) Padding(padding: padding, child: child)
        ],
      ),
    );
  }
}
