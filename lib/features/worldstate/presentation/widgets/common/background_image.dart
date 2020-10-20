import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/resources/resources.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
    @required this.imageUrl,
    this.alignment,
    this.height,
    this.padding,
    this.child,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;
  final Alignment alignment;
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  static const _derelict = AssetImage(Resources.derelictSkybox);

  Widget _imageBuilder(ImageProvider imageProvider) {
    return Container(
      alignment: alignment,
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstIn),
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => _imageBuilder(imageProvider),
      placeholder: (context, url) => _imageBuilder(_derelict),
      errorWidget: (context, url, dynamic error) => _imageBuilder(_derelict),
    );
  }
}
