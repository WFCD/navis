import 'package:flutter/material.dart';

import 'countdown.dart';
import 'row_item.dart';

class TimerBox extends StatelessWidget {
  const TimerBox({@required this.title, @required this.time});

  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RowItem(
          text: Text(title,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 16)),
          size: 20,
          child: CountdownBox(expiry: time, size: 16),
        ),
      ),
    );
  }
}
