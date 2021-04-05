import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.style,
    this.contentPadding,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return ListTile(
      title: Text(title, style: style ?? _style),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      contentPadding: contentPadding,
      dense: true,
    );
  }
}
