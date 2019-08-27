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
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final _node = Theme.of(context)
        .textTheme
        .subhead
        .copyWith(fontSize: 15, shadows: <Shadow>[shadow]);
    final _details = Theme.of(context).textTheme.caption.color;

    return Container(
      child: Column(children: <Widget>[
        Text(node, style: _node),
        Text('$description ($eta)', style: TextStyle(color: _details)),
      ]),
    );
  }
}
