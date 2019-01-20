import 'package:flutter/material.dart';

class StaticBox extends StatelessWidget {
  final Color color;
  final Widget child;

  StaticBox({this.color, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: child);
  }
}
