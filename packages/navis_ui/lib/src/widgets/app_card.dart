import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    this.title,
    this.color,
    this.margin,
    this.padding = const EdgeInsets.all(4),
    required this.child,
  }) : super(key: key);

  final String? title;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cardContent = Padding(
      padding: padding,
      child: title != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _BuildTitle(title: title),
                child,
              ],
            )
          : child,
    );

    return Card(
      color: color,
      margin: margin,
      child: cardContent,
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title!,
        textAlign: TextAlign.center,
        style: titleStyle,
      ),
    );
  }
}
