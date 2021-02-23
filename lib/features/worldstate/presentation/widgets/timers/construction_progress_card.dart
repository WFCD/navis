import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

// For now I've opted to not add unknown construction progress
// because well it's unknown and I've never actually seen it change
// will add it when it actually changes
class ConstructionProgressCard extends StatelessWidget {
  const ConstructionProgressCard({Key key, this.constructionProgress})
      : super(key: key);

  final List<Progress> constructionProgress;

  Widget _paintProgress(Progress progress, TextStyle style) {
    return SizedBox.fromSize(
      size: const Size(70.0, 70.0),
      child: CustomPaint(
        foregroundPainter: ProgressPainter(
          completeColor: progress.color,
          completePercent: progress.progress,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text('${progress.progress.toInt()}%', style: style),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final progress in constructionProgress)
              Column(
                children: <Widget>[
                  _paintProgress(progress, textTheme.headline6),
                  const SizedBox(height: 16.0),
                  Text(progress.name, style: textTheme.headline6)
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Progress {
  const Progress({
    @required this.progress,
    this.name = 'Unknown',
    this.color = Colors.white,
  }) : assert(progress != null || progress < 0);

  final double progress;
  final Color color;
  final String name;
}

class ProgressPainter extends CustomPainter {
  const ProgressPainter({
    @required this.completeColor,
    @required this.completePercent,
  })  : assert(completeColor != null),
        assert(completePercent != null || completePercent < 0.0);

  final Color completeColor;
  final double completePercent;

  @override
  void paint(Canvas canvas, Size size) {
    const width = 8.0;

    final line = Paint()
      ..color = Colors.white24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final arcAngle = 2 * pi * (completePercent / 100);
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas
      ..drawCircle(center, radius, line)
      ..drawArc(rect, -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return oldDelegate.completePercent != completePercent;
  }
}
