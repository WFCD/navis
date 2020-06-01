import 'package:flutter/material.dart';

class InvasionDetails extends StatelessWidget {
  const InvasionDetails({
    Key key,
    this.node,
    this.description,
    this.eta,
  }) : super(key: key);

  final String node;
  final String description;
  final String eta;

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final _node = Typography.whiteMountainView.subtitle1
        .copyWith(fontSize: 15, shadows: <Shadow>[shadow], color: color);

    return Container(
      child: Column(children: <Widget>[
        Text(node, style: _node),
        Text(
          '$description ($eta)',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(shadows: <Shadow>[shadow]),
        ),
      ]),
    );
  }
}
