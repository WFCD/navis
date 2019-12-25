import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
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
  factory ColoredContainer.text({
    String text,
    Color color,
    double fontSize,
    TextStyle style,
    EdgeInsetsGeometry padding = const EdgeInsets.all(6.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(3.0),
  }) {
    assert(
        fontSize == null || style == null,
        'Cannot provide both a fontSize and a TextStyle\n'
        'The fontSize argument is just a shorthand for "TextStlye(fontSize: fontSize)".');
    const _textColor = Colors.white;

    return ColoredContainer(
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
    const padding = 5.0;
    const leftPadding = EdgeInsets.only(left: padding);
    const rightPadding = EdgeInsets.only(right: padding);

    final icon = Padding(
      padding: iconTrailing ? leftPadding : rightPadding,
      child: this.icon,
    );

    iconTrailing ? children.insert(0, icon) : children.add(icon);
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
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
