import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.color,
    this.contentPadding = const EdgeInsets.all(4),
    this.clipBehavior,
    required this.child,
  });

  final Color? color;
  final EdgeInsetsGeometry contentPadding;
  final Clip? clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      clipBehavior: clipBehavior,
      child: Padding(
        padding: contentPadding,
        child: child,
      ),
    );
  }
}
