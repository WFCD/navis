import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final Widget child;
  final double height;
  final Duration duration;
  final Color color;

  Tiles({@required this.child,
    this.height,
    this.duration = const Duration(milliseconds: 200),
    this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 2.0, right: 2.0, bottom: 2.0),
      child: Card(
        elevation: 8.0,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: AnimatedContainer(
            duration: duration,
            margin: EdgeInsets.only(left: 3.0, right: 3.0),
            height: height,
            child: child),
      ),
    );
  }
}
