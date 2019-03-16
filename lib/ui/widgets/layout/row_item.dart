import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({
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

  final List<Widget> icons;
  final String text;
  final Widget child;
  final double size;
  final bool caption;

  @override
  Widget build(BuildContext context) {
    final style = caption
        ? Theme.of(context).textTheme.caption.copyWith(fontSize: 13)
        : Theme.of(context).textTheme.subhead.copyWith(fontSize: size);

    final List<Widget> children = [Text(text, style: style)];

    final _text = Container(child: Row(children: List.unmodifiable(() sync* {
      if (icons.isNotEmpty) {
        yield icons.map((i) =>
            Padding(padding: const EdgeInsets.only(right: 4.0), child: i));
      }
      yield* children;
    }())));

    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Expanded(child: _text), child]));
  }
}
