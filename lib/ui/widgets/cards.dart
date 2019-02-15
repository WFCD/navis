import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles({this.title, @required this.child, this.height, this.color});

  final String title;
  final Widget child;
  final double height;
  final Color color;

  Widget _buildTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[child];

    if (title != null) children.insert(0, _buildTitle(context, title));

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(6.0),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          margin: const EdgeInsets.all(4),
          height: height,
          alignment: Alignment.center,
          child: Column(children: children)),
    );
  }
}
