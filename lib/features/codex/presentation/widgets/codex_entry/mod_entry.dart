import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/resources.dart';

class ModFrame extends StatelessWidget {
  const ModFrame._({
    @required this.image,
    @required this.name,
    @required this.stats,
    @required this.compatName,
    @required this.background,
    @required this.cornerLights,
    @required this.frameTop,
    @required this.frameBottom,
    @required this.lowerTab,
    @required this.sideLight,
    @required this.topRightBacker,
  });

  factory ModFrame.common({
    String image,
    String name,
    String stats,
    String compatName,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      background: Image.asset(
        ModFrames.bronzeBackground,
        filterQuality: FilterQuality.high,
      ),
      cornerLights: Image.asset(
        ModFrames.bronzeCornerLights,
        filterQuality: FilterQuality.high,
      ),
      frameTop: Image.asset(
        ModFrames.bronzeFrameTop,
        filterQuality: FilterQuality.high,
      ),
      frameBottom: Image.asset(
        ModFrames.bronzeFrameBottom,
        filterQuality: FilterQuality.high,
      ),
      lowerTab: Image.asset(
        ModFrames.bronzeLowerTab,
        filterQuality: FilterQuality.high,
      ),
      sideLight: Image.asset(
        ModFrames.bronzeSideLight,
        filterQuality: FilterQuality.high,
      ),
      topRightBacker: Image.asset(
        ModFrames.bronzeTopRightBacker,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  factory ModFrame.uncommon({
    String image,
    String name,
    String stats,
    String compatName,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      background: Image.asset(ModFrames.silverBackground),
      cornerLights: Image.asset(ModFrames.silverCornerLights),
      frameTop: Image.asset(ModFrames.silverFrameTop),
      frameBottom: Image.asset(ModFrames.silverFrameBottom),
      lowerTab: Image.asset(ModFrames.silverLowerTab),
      sideLight: Image.asset(ModFrames.silverSideLight),
      topRightBacker: Image.asset(ModFrames.silverTopRightBacker),
    );
  }

  factory ModFrame.rare({
    String image,
    String name,
    String stats,
    String compatName,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      background: Image.asset(ModFrames.goldBackground),
      cornerLights: Image.asset(ModFrames.goldCornerLights),
      frameTop: Image.asset(ModFrames.goldFrameTop),
      frameBottom: Image.asset(ModFrames.goldFrameBottom),
      lowerTab: Image.asset(ModFrames.goldLowerTab),
      sideLight: Image.asset(ModFrames.goldSideLight),
      topRightBacker: Image.asset(ModFrames.goldTopRightBacker),
    );
  }

  factory ModFrame.primed({
    String image,
    String name,
    String stats,
    String compatName,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      background: Image.asset(ModFrames.legendaryBackground),
      cornerLights: Image.asset(ModFrames.legendaryCornerLights),
      frameTop: Image.asset(ModFrames.legendaryFrameTop),
      frameBottom: Image.asset(ModFrames.legendaryFrameBottom),
      lowerTab: Image.asset(ModFrames.legendaryLowerTab),
      sideLight: Image.asset(ModFrames.legendarySideLight),
      topRightBacker: Image.asset(ModFrames.legendaryTopRightBacker),
    );
  }

  final String image, name, stats, compatName;

  final Image background;

  final Image cornerLights;

  final Image frameBottom;

  final Image frameTop;

  final Image lowerTab;

  final Image sideLight;

  final Image topRightBacker;

  static final completer = Completer<ImageInfo>();

  Future<ui.Image> getImage() async {
    ImageInfo imageInfo;
    final img = CachedNetworkImageProvider(image);

    img.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        imageInfo = info;
      }),
    );

    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    const descriptionColor = Color(0xFFF5DEB3);
    const size = Size(260.0, 575.0);

    final imageHeight = (size.height / 100) * 35;
    final textTheme = Theme.of(context)?.textTheme;

    return Center(
      child: Container(
        constraints: BoxConstraints.tight(size),
        child: Stack(
          alignment: Alignment.center,
          children: [
            background,
            Positioned(
              top: 120,
              left: 10,
              child: FutureBuilder<ui.Image>(
                future: getImage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomPaint(
                      size: Size(size.width, imageHeight),
                      painter: ModImageCropped(
                        image: snapshot.data,
                        width: size.width - 19,
                        height: imageHeight,
                      ),
                    );
                  }

                  return Container(
                    height: imageHeight,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Positioned(
              top: 100,
              child: frameTop,
            ),
            Positioned(
              bottom: 75,
              child: frameBottom,
            ),
            Positioned(
              bottom: 112,
              right: -3,
              child: cornerLights,
            ),
            Positioned(
              bottom: 109,
              left: 63,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: cornerLights,
              ),
            ),
            Positioned(bottom: 130, child: lowerTab),
            Positioned(right: 1, bottom: 170, child: sideLight),
            Positioned(
              left: 18,
              bottom: 170,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: sideLight,
              ),
            ),
            Positioned(
              top: 130,
              right: 7,
              child: topRightBacker,
            ),
            Positioned(
              bottom: 230,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: textTheme?.headline6?.copyWith(color: descriptionColor),
              ),
            ),
            Positioned(
              bottom: 190,
              child: Container(
                width: 225,
                child: Text(
                  stats,
                  textAlign: TextAlign.center,
                  style: textTheme?.caption?.copyWith(color: descriptionColor),
                ),
              ),
            ),
            Positioned(
              bottom: 133,
              child: Text(
                compatName,
                textAlign: TextAlign.center,
                style: textTheme?.subtitle1?.copyWith(color: descriptionColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModImageCropped extends CustomPainter {
  const ModImageCropped({
    @required this.image,
    @required this.width,
    @required this.height,
  });

  final ui.Image image;
  final double width;
  final double height;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final paint = Paint();

    canvas.drawAtlas(
      image,
      [
        // Identity transform
        RSTransform.fromComponents(
          rotation: 0.0,
          scale: 1.0,
          anchorX: 0.0,
          anchorY: 0.0,
          translateX: 0.0,
          translateY: 0.0,
        )
      ],
      [
        Rect.fromCenter(
          center: const Offset(150.0, 90.0),
          width: width,
          height: height,
        )
      ],
      [/* No need for colors */],
      BlendMode.src,
      null, // No need for cullRect,
      paint,
    );
  }

  @override
  bool shouldRepaint(ModImageCropped oldDelegate) {
    return false;
  }
}
