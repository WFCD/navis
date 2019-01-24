import 'package:flutter/material.dart';

class StaticBox extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry padding;

  StaticBox({this.child, this.color, this.padding = const EdgeInsets.all(3.0)});

//create simple text box with hard coded color of white
  factory StaticBox.text(
      {String text,
      Color color,
      double size,
      EdgeInsets padding = const EdgeInsets.all(3.0)}) {
    return StaticBox(
      padding: padding,
      color: color,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: size)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        margin: padding,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: child);
  }
}
