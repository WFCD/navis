import 'dart:math';

import 'package:flutter/material.dart';

class WarframeSpinner extends StatefulWidget {
  const WarframeSpinner({super.key, this.size});

  final double? size;

  @override
  State<WarframeSpinner> createState() => _WarframeSpinnerState();
}

typedef RingAnimation = ({Animation<double> size, Animation<double> rotation});

class _WarframeSpinnerState extends State<WarframeSpinner> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<RingAnimation> _rings = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Durations.extralong4 * 1.8,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    const start = .2;
    var maxSize = 0.0;
    for (var i = 0; i < 3; i++) {
      maxSize += start;

      final size = TweenSequence<double>([
        TweenSequenceItem(
          tween: ConstantTween(start),
          weight: 5,
        ),
        TweenSequenceItem(
          tween: Tween(begin: start, end: maxSize),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: ConstantTween(maxSize),
          weight: 60,
        ),
        TweenSequenceItem(
          tween: Tween(begin: maxSize, end: start),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: ConstantTween(start),
          weight: 5,
        ),
      ]).animate(curve);

      const radians = pi / 2;
      final rotation = TweenSequence<double>([
        TweenSequenceItem(
          tween: ConstantTween(0),
          weight: 10 + (i * 10),
        ),
        TweenSequenceItem(
          tween: Tween(begin: 0, end: radians),
          weight: 10,
        ),
        TweenSequenceItem(
          tween: ConstantTween(radians),
          weight: 20,
        ),
      ]).animate(curve);

      _rings.add((size: size, rotation: rotation));
    }

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rings = theme.colorScheme.primary;
    final background = theme.colorScheme.secondaryContainer;

    final mediaSize = MediaQuery.sizeOf(context);
    final size = Size.square(widget.size ?? mediaSize.width / 3);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: _WarframeSpinnerPainter(
            primary: rings,
            background: background,
            rings: _rings.map((ra) => (size: ra.size.value, rotation: ra.rotation.value)).toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef Ring = ({double size, double rotation});

class _WarframeSpinnerPainter extends CustomPainter {
  const _WarframeSpinnerPainter({
    required this.primary,
    required this.background,
    required this.rings,
  });

  final Color primary;
  final Color background;
  final List<Ring> rings;

  void _drawDiamond(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  void _drawInnerDiamond(
    Canvas canvas,
    Size outer,
    Size inner,
    Paint paint,
    double rotation,
  ) {
    canvas
      ..save()
      ..translate(outer.width / 2, outer.height / 2)
      ..rotate(rotation)
      ..translate(-inner.width / 2, -inner.height / 2)
      ..drawPath(
        Path()
          ..moveTo(inner.width / 2, 0)
          ..lineTo(inner.width, inner.height / 2)
          ..lineTo(inner.width / 2, inner.height)
          ..lineTo(0, inner.height / 2)
          ..close(),
        paint,
      )
      ..restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = background
      ..style = PaintingStyle.fill;

    _drawDiamond(canvas, size, backgroundPaint);

    var currentWidth = 1.0;
    var currentOpacity = .2;
    for (final ring in rings) {
      final innerSize = Size(
        size.width * ring.size,
        size.height * ring.size,
      );

      currentWidth += .5;
      currentOpacity += .3;
      final outerPaint = Paint()
        ..color = primary.withValues(alpha: min(currentOpacity, 1))
        ..style = PaintingStyle.stroke
        ..strokeWidth = currentWidth;

      _drawInnerDiamond(
        canvas,
        size,
        innerSize,
        outerPaint,
        ring.rotation,
      );
    }
  }

  @override
  bool shouldRepaint(_WarframeSpinnerPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.background != background || oldDelegate.rings != rings;
  }
}
