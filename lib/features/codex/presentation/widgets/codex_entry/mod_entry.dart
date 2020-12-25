import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/resources.dart';
import '../../../utils/mod_polarity.dart';

class ModFrame extends StatelessWidget {
  const ModFrame._({
    @required this.image,
    @required this.name,
    @required this.stats,
    @required this.compatName,
    @required this.maxRank,
    @required this.baseDrain,
    @required this.polarity,
    @required this.rarity,
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
    int maxRank,
    int baseDrain,
    String polarity,
    String rarity,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      maxRank: maxRank,
      baseDrain: baseDrain,
      polarity: polarity,
      rarity: rarity,
      background: Image.asset(ModFrames.bronzeBackground),
      cornerLights: Image.asset(ModFrames.bronzeCornerLights),
      frameTop: Image.asset(ModFrames.bronzeFrameTop),
      frameBottom: Image.asset(ModFrames.bronzeFrameBottom),
      lowerTab: Image.asset(ModFrames.bronzeLowerTab),
      sideLight: Image.asset(ModFrames.bronzeSideLight),
      topRightBacker: Image.asset(ModFrames.bronzeTopRightBacker),
    );
  }

  factory ModFrame.uncommon({
    String image,
    String name,
    String stats,
    String compatName,
    int maxRank,
    int baseDrain,
    String polarity,
    String rarity,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      maxRank: maxRank,
      baseDrain: baseDrain,
      polarity: polarity,
      rarity: rarity,
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
    int maxRank,
    int baseDrain,
    String polarity,
    String rarity,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      maxRank: maxRank,
      baseDrain: baseDrain,
      polarity: polarity,
      rarity: rarity,
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
    int maxRank,
    int baseDrain,
    String polarity,
    String rarity,
  }) {
    return ModFrame._(
      image: image,
      name: name,
      stats: stats,
      compatName: compatName,
      maxRank: maxRank,
      baseDrain: baseDrain,
      polarity: polarity,
      rarity: rarity,
      background: Image.asset(ModFrames.legendaryBackground),
      cornerLights: Image.asset(ModFrames.legendaryCornerLights),
      frameTop: Image.asset(ModFrames.legendaryFrameTop),
      frameBottom: Image.asset(ModFrames.legendaryFrameBottom),
      lowerTab: Image.asset(ModFrames.legendaryLowerTab),
      sideLight: Image.asset(ModFrames.legendarySideLight),
      topRightBacker: Image.asset(ModFrames.legendaryTopRightBacker),
    );
  }

  final String image, name, stats, compatName, polarity, rarity;
  final int maxRank, baseDrain;

  final Image background;

  final Image cornerLights;

  final Image frameBottom;

  final Image frameTop;

  final Image lowerTab;

  final Image sideLight;

  final Image topRightBacker;

  static final completer = Completer<ImageInfo>();

  static final rankSlot = Image.asset(ModFrames.rankSlotEmpty);

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
    const size = Size(260.0, 350.0);

    final imageHeight = (size.height / 100) * 50;
    final textTheme = Theme.of(context)?.textTheme;

    return Center(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: background.image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: 0,
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
              top: -15,
              child: frameTop,
            ),
            Positioned(
              bottom: -40,
              child: frameBottom,
            ),
            Positioned(
              bottom: rarity != 'Legendary' ? -14 : -27,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [for (int i = 0; i < maxRank; i++) rankSlot],
              ),
            ),
            Positioned(
              bottom: -10,
              right: -3,
              child: cornerLights,
            ),
            Positioned(
              bottom: -10,
              left: 63,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: cornerLights,
              ),
            ),
            Positioned(bottom: 20, child: lowerTab),
            Positioned(right: 1, bottom: 51, child: sideLight),
            Positioned(
              left: 18,
              bottom: 51,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: sideLight,
              ),
            ),
            Positioned(
              top: 15,
              right: 7,
              child: topRightBacker,
            ),
            Positioned(
              top: 20,
              right: 30,
              child: Text(
                baseDrain.toString(),
                style: Theme.of(context)
                    .textTheme
                    ?.caption
                    ?.copyWith(fontSize: 15, color: _textColor(rarity)),
              ),
            ),
            Positioned(
              top: 19,
              right: 9,
              child: Image.asset(
                getPolarityWithRarity(rarity, polarity),
                width: 19,
              ),
            ),
            Positioned(
              top: 200,
              child: ModDrescription(
                name: name,
                stats: stats,
                rarity: rarity,
              ),
            ),
            Positioned(
              bottom: 25,
              child: Text(
                compatName,
                textAlign: TextAlign.center,
                style:
                    textTheme?.subtitle1?.copyWith(color: _textColor(rarity)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _textColor(String rarity) {
  switch (rarity) {
    case 'Common':
      return const Color(0xFFF5DEB3);
    case 'Rare':
      return const Color(0xFFFEEBC1);
    default:
      return Colors.white;
  }
}

class ModDrescription extends StatelessWidget {
  const ModDrescription({Key key, this.name, this.stats, this.rarity})
      : super(key: key);

  final String name, stats, rarity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: textTheme?.headline6?.copyWith(color: _textColor(rarity)),
          ),
          const SizedBox(height: 15),
          Container(
            width: 225,
            child: Text(
              stats,
              textAlign: TextAlign.center,
              style: textTheme?.caption?.copyWith(color: _textColor(rarity)),
            ),
          ),
        ],
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
