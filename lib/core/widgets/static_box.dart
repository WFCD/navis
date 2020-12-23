import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../themes/colors.dart';

class StaticBox extends StatelessWidget {
  const StaticBox({
    Key key,
    @required this.tooltip,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
    this.height,
    this.width,
    this.color,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

//create simple text box with hard coded color of white
  factory StaticBox.text({
    String text,
    Color color,
    double fontSize,
    TextStyle style,
    EdgeInsetsGeometry padding = const EdgeInsets.all(6.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(3.0),
  }) {
    const _textColor = Colors.white;

    return StaticBox(
      tooltip: text,
      padding: padding,
      margin: margin,
      color: color,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style?.copyWith(color: _textColor) ??
            TextStyle(color: _textColor, fontSize: fontSize),
      ),
    );
  }
  final String tooltip;

  final EdgeInsetsGeometry padding, margin;
  final double height;
  final double width;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: AnimatedContainer(
        duration: 250.milliseconds,
        padding: padding,
        height: height,
        width: width,
        margin: margin,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color ?? primary,
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        child: child,
      ),
    );
  }
}
