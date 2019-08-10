import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles({this.title, @required this.child, this.height, this.color});

  final String title;
  final Widget child;
  final double height;
  final Color color;

  Widget _buildTitle(BuildContext context, String text) {
    final titleStyle =
        Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 6.0,
      child: Container(
          margin: const EdgeInsets.fromLTRB(4, 6, 4, 6),
          padding: const EdgeInsets.all(2),
          height: height,
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            if (title != null) _buildTitle(context, title),
            child
          ])),
    );
  }
}
