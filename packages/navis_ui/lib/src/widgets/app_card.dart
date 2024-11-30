import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.title,
    this.color,
    this.padding = const EdgeInsets.all(4),
    this.clipBehavior,
    required this.child,
  });

  final String? title;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final Clip? clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      clipBehavior: clipBehavior,
      child: Padding(
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
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
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
