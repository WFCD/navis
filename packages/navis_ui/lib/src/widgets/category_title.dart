import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.style,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 15,
          color: Theme.of(context).colorScheme.secondary,
        );

    return ListTile(
      title: Text(title),
      titleTextStyle: this.style ?? style,
      subtitle: subtitle != null ? Text(subtitle!) : null,
      contentPadding: contentPadding,
    );
  }
}
