import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    this.height,
    this.color,
    this.title,
    @required this.child,
  }) : super(key: key);

  final double height;
  final Color color;
  final String title;
  final Widget child;

  Widget _buildTitle(BuildContext context, String text) {
    final titleStyle =
        Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w500);

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
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
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
