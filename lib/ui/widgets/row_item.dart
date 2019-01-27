import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final List<Widget> icons;
  final String text;
  final Widget child;
  final double size;
  final bool caption;

  RowItem({
    this.icons = const <Widget>[],
    @required this.text,
    @required this.child,
    this.size,
    this.caption = false,
  });

  factory RowItem.richText(
      {String title, String richText, Color color, double size}) {
    return RowItem(
        text: title,
        child: Text(richText,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size, color: color)));
  }

  _addIcons(bool notEmpty, List<Widget> children) {
    if (notEmpty)
      children.insertAll(
          0,
          icons.map(
              (i) => Padding(padding: EdgeInsets.only(right: 4.0), child: i)));
  }

  @override
  Widget build(BuildContext context) {
    final style = caption
        ? Theme.of(context).textTheme.caption.copyWith(fontSize: 13)
        : Theme.of(context).textTheme.subhead.copyWith(fontSize: size);

    List<Widget> children = [Text(text, style: style)];
    _addIcons(icons.isNotEmpty, children);

    final _text = Container(child: Row(children: children));

    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Expanded(child: _text), child]));
  }
}
