import 'package:flutter/material.dart';

import 'countdown.dart';
import 'row_item.dart';

class CountdownBanner extends StatelessWidget {
  const CountdownBanner({
    Key key,
    @required this.message,
    @required this.time,
    this.color,
    this.margin = const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
  })  : assert(message != null),
        assert(time != null),
        super(key: key);

  final String message;
  final DateTime time;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color,
      child: RowItem(
        text: Text(
          message,
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
        ),
        child: CountdownTimer(expiry: time, size: 16),
      ),
    );
  }
}
