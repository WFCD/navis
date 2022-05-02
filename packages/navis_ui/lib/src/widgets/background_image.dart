import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

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

  static const _derelict =
      AssetImage('assets/Derelict.webp', package: 'navis_ui');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        if (imageUrl == null) {
          return ImageContainer(
            imageProvider: _derelict,
            height: height,
            padding: padding,
            child: const SizedBox(),
          );
        }

        return CachedNetworkImage(
          imageUrl: imageUrl!,
          height: height,
          width: constraints.maxWidth,
          imageBuilder: (context, imageProvider) {
            return ImageContainer(
              imageProvider: imageProvider,
              height: height,
              padding: padding,
              child: child,
            );
          },
          placeholder: (context, url) {
            return ImageContainer(
              imageProvider: _derelict,
              height: height,
              padding: padding,
              child: child,
            );
          },
          errorWidget: (context, url, dynamic error) {
            return ImageContainer(
              imageProvider: _derelict,
              height: height,
              padding: padding,
              child: child,
            );
          },
        );
      },
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    required this.imageProvider,
    required this.height,
    required this.padding,
    required this.child,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisTheme.dark,
      child: Container(
        height: height,
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
