import 'package:flutter/material.dart';

import 'countdown.dart';
import 'row_item.dart';

class CountdownBanner extends StatelessWidget {
  const CountdownBanner({@required this.message, @required this.time});

  final String message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RowItem(
          text: Text(message,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 16)),
          size: 20,
          child: CountdownTimer(expiry: time, size: 16),
        ),
      ),
    );
  }
}
