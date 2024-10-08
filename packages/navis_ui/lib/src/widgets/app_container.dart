import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    super.key,
    required this.tooltip,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(3),
    this.height,
    this.width,
    this.color,
    required this.child,
  });

  factory ColoredContainer.text({
    required String text,
    Color? color,
    TextStyle? style,
    EdgeInsetsGeometry padding = const EdgeInsets.all(6),
    EdgeInsetsGeometry margin = const EdgeInsets.all(3),
  }) {
    return ColoredContainer(
      tooltip: text,
      padding: padding,
      margin: margin,
      color: color,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }

  final String tooltip;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        padding: padding,
        height: height,
        width: width,
        margin: margin,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color ?? context.theme.colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: child,
      ),
    );
  }
}
