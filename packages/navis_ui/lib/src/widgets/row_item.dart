import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    Key? key,
    this.icons = const <Widget>[],
    required this.text,
    required this.child,
    this.padding,
  }) : super(key: key);

  factory RowItem.richText({
    required String title,
    required String richText,
    required Color color,
    required double size,
  }) {
    return RowItem(
      text: Text(title),
      child: Text(
        richText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: color,
        ),
      ),
    );
  }

  final List<Widget> icons;
  final Widget text;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final _icons = icons.map((icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: icon,
      );
    });

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          if (_icons.isNotEmpty) ..._icons,
          text,
          const Spacer(),
          Flexible(flex: 3, child: child)
        ],
      ),
    );
  }
}
