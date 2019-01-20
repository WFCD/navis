import 'package:flutter/material.dart';

class StaticBox extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry padding;

  StaticBox(
      {@required this.child,
      this.color,
      this.padding = const EdgeInsets.all(4.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: child);
  }
}
