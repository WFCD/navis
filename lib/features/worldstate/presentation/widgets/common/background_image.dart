import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/resources.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    this.imageUrl,
    this.height,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  final String? imageUrl;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  static const _derelict = AssetImage(NavisAssets.derelict);

  Widget _imageBuilder(ImageProvider imageProvider) {
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
          Padding(padding: padding, child: child)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: 250,
        imageBuilder: (context, imageProvider) => _imageBuilder(imageProvider),
        placeholder: (context, url) => _imageBuilder(_derelict),
        errorWidget: (context, url, dynamic error) => _imageBuilder(_derelict),
      );
    } else {
      return _imageBuilder(_derelict);
    }
  }
}
