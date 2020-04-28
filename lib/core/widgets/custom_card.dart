import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    this.title,
    @required this.child,
    this.height,
    this.color,
    this.margin = const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
  }) : super(key: key);

  final double height;
  final Color color;
  final EdgeInsetsGeometry margin, padding;
  final String title;
  final Widget child;

  Widget _buildTitle(BuildContext context, String text) {
    final titleStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: titleStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 4.0,
      child: AnimatedContainer(
        margin: margin,
        padding: padding,
        height: height,
        duration: const Duration(milliseconds: 250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (title != null) _buildTitle(context, title),
            child
          ],
        ),
      ),
    );
  }
}
