import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/app_colors.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    Key? key,
    required this.tooltip,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(3),
    this.height,
    this.width,
    this.color,
    required this.child,
  }) : super(key: key);

  factory ColoredContainer.text({
    required String text,
    Color? color,
    double? fontSize,
    TextStyle? style,
    EdgeInsetsGeometry padding = const EdgeInsets.all(6),
    EdgeInsetsGeometry margin = const EdgeInsets.all(3),
  }) {
    const _textColor = Colors.white;

    return ColoredContainer(
      tooltip: text,
      padding: padding,
      margin: margin,
      color: color,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style?.copyWith(color: _textColor) ??
            TextStyle(color: _textColor, fontSize: fontSize),
      ),
    );
  }
  final String tooltip;

  final EdgeInsetsGeometry padding, margin;
  final double? height, width;
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
          color: color ?? NavisColors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: child,
      ),
    );
  }
}
