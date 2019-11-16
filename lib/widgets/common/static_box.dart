import 'package:flutter/material.dart';

class StaticBox extends StatelessWidget {
  const StaticBox({
    Key key,
    @required this.child,
    this.icon,
    this.iconTrailing = false,
    this.color,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
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
      padding: padding,
      margin: margin,
      color: color ?? Colors.blueAccent[400],
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style?.copyWith(color: _textColor) ??
            TextStyle(color: _textColor, fontSize: fontSize),
      ),
    );
  }
  final double height;
  final double width;
  final Color color;
  final Widget icon;
  final Widget child;
  final bool iconTrailing;
  final EdgeInsetsGeometry padding, margin;

  void _addIcon(List<Widget> children) {
    const padding = 8.0;

    if (iconTrailing) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: padding),
          child: icon,
        ),
      );
      return;
    }

    children.insert(
      0,
      Padding(
        padding: const EdgeInsets.only(right: padding),
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[child];

    if (icon != null) _addIcon(children);

    return Container(
      padding: padding,
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
