import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../resources/assets.dart';

class InvasionBar extends StatelessWidget {
  final String attackingFaction, defendingFaction;
  final double progress;
  final double width;
  final double lineHeight;
  final EdgeInsets padding;
  final Color color;

  InvasionBar(
      {this.progress,
      this.width,
      this.padding,
      @required this.attackingFaction,
      @required this.defendingFaction,
      this.color,
      this.lineHeight})
      : assert(attackingFaction != null),
        assert(defendingFaction != null),
        assert(progress != null);

  _factionIcon(String faction) {
    switch (faction) {
      case 'Grineer':
        return ImageAssets.grineer;
      case 'Corpus':
        return ImageAssets.corpus;
      case 'Corrupted':
        return ImageAssets.corrupted;
      default:
        return ImageAssets.infested;
    }
  }

  _factionColor(String faction) {
    switch (faction) {
      case 'Corpus':
        return Colors.blue;
      case 'Grineer':
        return Colors.red[700];
      case 'Corrupted':
        return Colors.yellow[300];
      case 'Infested':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                              progressColor: _factionColor(attackingFaction),
                              backgroundColor: _factionColor(defendingFaction),
                              lineWidth: lineHeight),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(_factionIcon(attackingFaction),
                                    size: 15.0, color: color),
                                Icon(_factionIcon(defendingFaction),
                                    size: 15.0, color: color)
                              ]))))
            ]));
  }
}

class _InvasionBar extends CustomPainter {
  final _attackingFaction = Paint();
  final _defendingFaction = Paint();
  final backgroundColor;
  final progressColor;
  final progress;
  final lineWidth;

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

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height / 2);
    final end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, _defendingFaction);
    canvas.drawLine(start, Offset(size.width * progress, size.height / 2),
        _attackingFaction);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
