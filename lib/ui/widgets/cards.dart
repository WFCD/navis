import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;

  Tiles({@required this.child, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
          margin: EdgeInsets.only(left: 3.0, right: 3.0),
          height: height,
          child: child),
    );
  }
}
