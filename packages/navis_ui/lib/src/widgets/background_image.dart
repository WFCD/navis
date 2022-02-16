import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

  static const _derelict = AssetImage('assets/Derelict.webp');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        if (imageUrl == null) {
          return _ImageContainer(
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
    required this.child,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            colors: <Color>[Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
