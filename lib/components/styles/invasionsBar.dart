import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:navis/utils/factionutils.dart';

class InvasionBar extends StatelessWidget {
  const InvasionBar(
      {Key key,
      @required this.progress,
      this.width,
      this.padding,
      @required this.attackingFaction,
      @required this.defendingFaction,
      this.color,
      this.lineHeight})
      : assert(attackingFaction != null),
        assert(defendingFaction != null),
        assert(progress != null),
        super(key: key);

  final String attackingFaction, defendingFaction;
  final double progress;
  final double width;
  final double lineHeight;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: lineHeight * 2,
                      width: width,
                      padding: padding,
                      child: CustomPaint(
                          willChange: true,
                          painter: _InvasionBar(
                              progress: progress,
                              progressColor: factionColor(attackingFaction),
                              backgroundColor: factionColor(defendingFaction),
                              lineWidth: lineHeight),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FactionIcon(attackingFaction,
                                    size: 15, hasColor: false),
                                FactionIcon(defendingFaction,
                                    size: 15, hasColor: false),
                              ]))))
            ]));
  }
}

class _InvasionBar extends CustomPainter {
  _InvasionBar(
      {this.progress,
      this.progressColor,
      this.backgroundColor,
      this.lineWidth}) {
    _attackingFaction.color = progressColor;
    _attackingFaction.style = PaintingStyle.stroke;
    _attackingFaction.strokeWidth = lineWidth;
    _attackingFaction.strokeCap = StrokeCap.butt;

    _defendingFaction.color = backgroundColor;
    _defendingFaction.style = PaintingStyle.stroke;
    _defendingFaction.strokeWidth = lineWidth;
    _defendingFaction.strokeCap = StrokeCap.butt;
  }

  final Paint _attackingFaction = Paint();
  final Paint _defendingFaction = Paint();
  final Color backgroundColor;
  final Color progressColor;
  final double progress;
  final double lineWidth;

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
