import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final Color color;

  Tiles({this.title, @required this.child, this.height, this.color});

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
    List<Widget> children = [child];

    if (title != null) children.insert(0, _buildTitle(context, title));

    return Card(
      elevation: 2,
      margin: EdgeInsets.all(6),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          margin: EdgeInsets.all(4),
          height: height,
          alignment: Alignment.center,
          child: Column(children: children)),
    );
  }
}
