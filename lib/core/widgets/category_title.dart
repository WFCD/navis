import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    @required this.title,
    this.style,
    this.alignment = Alignment.centerLeft,
    this.addPadding = true,
  });

  final String title;
  final bool addPadding;
  final AlignmentGeometry alignment;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return Container(
      margin: addPadding
          ? const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0)
          : null,
      alignment: alignment,
      child: Text(title, style: style ?? _style),
    );
  }
}
