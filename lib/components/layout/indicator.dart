import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class Indicator extends StatelessWidget {
  Indicator(
      {Key key,
      @required this.numberOfDot,
      this.position = 0,
      this.dotColor = Colors.grey,
      this.dotActiveColor = Colors.lightBlue,
      this.dotSize = kDefaultSize,
      this.dotActiveSize = kDefaultSize,
      this.dotShape = kDefaultShape,
      this.dotActiveShape = kDefaultShape,
      this.dotSpacing = kDefaultSpacing})
      : assert(numberOfDot != null),
        assert(position != null),
        assert(dotColor != null),
        assert(dotActiveColor != null),
        assert(dotSize != null),
        assert(dotActiveSize != null),
        assert(dotShape != null),
        assert(dotActiveShape != null),
        assert(dotSpacing != null),
        assert(position < numberOfDot,
            'The position must be inferior of numberOfDot (position start at 0). Example for active last dot: numberOfDot=3 / position=2'),
        super(key: key);

  static const Size kDefaultSize = Size.square(9.0);
  static const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
  static const ShapeBorder kDefaultShape = CircleBorder();

  final int numberOfDot;
  final int position;
  final Color dotColor;
  final Color dotActiveColor;
  final Size dotSize;
  final Size dotActiveSize;
  final ShapeBorder dotShape;
  final ShapeBorder dotActiveShape;
  final EdgeInsets dotSpacing;

  @override
  Widget build(BuildContext context) {
    final multiTracks = MultiTrackTween(<Track>[
      Track('shape')
        ..add(const Duration(milliseconds: 500),
            ShapeBorderTween(begin: dotShape, end: dotActiveShape)),
      Track('color')
        ..add(const Duration(milliseconds: 350),
            ColorTween(begin: dotColor, end: dotActiveColor))
    ]);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < numberOfDot; i++)
            ControlledAnimation(
              duration: multiTracks.duration,
              tween: multiTracks,
              playback: (i == position)
                  ? Playback.PLAY_FORWARD
                  : Playback.PLAY_REVERSE,
              builder: (context, tracks) {
                return Container(
                  width: ((i == position) ? dotActiveSize : dotSize).width,
                  height: ((i == position) ? dotActiveSize : dotSize).height,
                  margin: dotSpacing,
                  decoration: ShapeDecoration(
                      color: tracks['color'], shape: tracks['shape']),
                );
              },
            )
        ],
      ),
    );
  }
}
