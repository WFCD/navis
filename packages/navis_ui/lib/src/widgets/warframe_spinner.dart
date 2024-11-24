import 'dart:math';

import 'package:flutter/material.dart';

class WarframeSpinner extends StatefulWidget {
  const WarframeSpinner({super.key});

  @override
  State<WarframeSpinner> createState() => _WarframeSpinnerState();
}

class _WarframeSpinnerState extends State<WarframeSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Ring> _rings = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Durations.extralong4 * 1.5,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    for (var i = 1; i <= 3; i++) {
      const ratio = _ThrobberCustomPainter.ratio;
      final maxSize = ratio * i;

      final size = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: ratio, end: maxSize),
          weight: 10,
        ),
        TweenSequenceItem(
          tween: ConstantTween(maxSize),
          weight: 80,
        ),
        TweenSequenceItem(
          tween: Tween(begin: maxSize, end: ratio),
          weight: 15,
        ),
        TweenSequenceItem(
          tween: ConstantTween(ratio),
          weight: 5,
        ),
      ]).animate(curve);

      final rotation = TweenSequence<double>([
        TweenSequenceItem(
          tween: ConstantTween(0),
          weight: 10 + (i * 10),
        ),
        TweenSequenceItem(
          tween: Tween(begin: 0, end: pi / 2),
          weight: 10,
        ),
        TweenSequenceItem(
          tween: ConstantTween(pi / 2),
          weight: 20,
        ),
      ]).animate(curve);

      _rings.add((layer: i, size: size, rotation: rotation));
    }

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final background = theme.colorScheme.primaryContainer;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(MediaQuery.sizeOf(context).width / 2),
          painter: _ThrobberCustomPainter(
            primary: primary,
            background: background,
            rings: _rings,
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

typedef Ring = ({
  int layer,
  Animation<double> size,
  Animation<double> rotation,
});

class _ThrobberCustomPainter extends CustomPainter {
  const _ThrobberCustomPainter({
    required this.primary,
    required this.background,
    required this.rings,
  });

  final Color primary;
  final Color background;
  final List<Ring> rings;

  static const ratio = .2;

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

    for (final ring in rings) {
      final innerSize = Size(
        size.width * ring.size.value,
        size.height * ring.size.value,
      );

      final outerPaint = Paint()
        ..color = primary.withOpacity(ring.layer * .3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0 * ring.layer;

      _drawInnerDiamond(
        canvas,
        size,
        innerSize,
        outerPaint,
        ring.rotation.value,
      );
    }
  }

  @override
  bool shouldRepaint(_ThrobberCustomPainter oldDelegate) => true;
}
