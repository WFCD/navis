import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    Key key,
    @required this.text,
    @required this.child,
    this.icons = const <Widget>[],
    this.size,
    this.caption = false,
  })  : assert(text != null),
        assert(child != null),
        super(key: key);

  final List<Widget> icons;
  final Widget text;
  final Widget child;
  final double size;
  final bool caption;

  void addIcons(List<Widget> children) {
    final icons = this.icons.map<Widget>(
        (i) => Padding(padding: const EdgeInsets.only(right: 4.0), child: i));

    children.insertAll(0, icons);
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[text, const Spacer(), child];

    if (icons.isNotEmpty) addIcons(children);

    return FittedBox(
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
