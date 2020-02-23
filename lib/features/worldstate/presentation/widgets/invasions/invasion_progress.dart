import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:navis/core/widgets/widgets.dart';

class InvasionProgress extends StatelessWidget {
  const InvasionProgress({
    Key key,
    @required this.progress,
    @required this.attackingFaction,
    @required this.defendingFaction,
  })  : assert(attackingFaction != null),
        assert(defendingFaction != null),
        assert(progress != null),
        super(key: key);

  final String attackingFaction, defendingFaction;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(16.0),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            height: 30,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _InvasionBar(
                  progress: progress,
                  attackingFaction: attackingFaction,
                  defendingFaction: defendingFaction,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class _InvasionBar extends CustomPainter {
  _InvasionBar({
    @required this.progress,
    @required this.attackingFaction,
    @required this.defendingFaction,
  })  : assert(progress != null),
        assert(attackingFaction != null),
        assert(defendingFaction != null) {
    const strokeWidth = 19.0;
    _attackingFaction.color = factionColor(attackingFaction);
    _attackingFaction.style = PaintingStyle.stroke;
    _attackingFaction.strokeWidth = strokeWidth;
    _attackingFaction.strokeCap = StrokeCap.butt;

    _defendingFaction.color = factionColor(defendingFaction);
    _defendingFaction.style = PaintingStyle.stroke;
    _defendingFaction.strokeWidth = strokeWidth;
    _defendingFaction.strokeCap = StrokeCap.butt;
  }

  final Paint _attackingFaction = Paint();
  final Paint _defendingFaction = Paint();

  final String attackingFaction, defendingFaction;

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset start = Offset(0.0, size.height / 2);
    final Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, _defendingFaction);
    canvas.drawLine(start, Offset(size.width * progress, size.height / 2),
        _attackingFaction);
  }

  @override
  bool shouldRebuildSemantics(_InvasionBar oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRepaint(_InvasionBar oldDelegate) =>
      oldDelegate.progress != progress;
}
