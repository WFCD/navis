import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  const CategoryName({
    Key key,
    @required this.title,
    this.style,
    this.alignment = Alignment.centerLeft,
  })  : assert(title != null),
        super(key: key);

  final String title;
  final AlignmentGeometry alignment;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
      child: Text(title, style: style ?? _style),
    );
  }
}
