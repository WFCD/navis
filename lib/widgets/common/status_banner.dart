import 'package:flutter/material.dart';
import 'package:navis/widgets/common/timer.dart';

import 'row_item.dart';

class StatusBanner extends StatelessWidget {
  const StatusBanner({@required this.title, @required this.time});

  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final _titleStyle =
        Theme.of(context).textTheme.title.copyWith(fontSize: 16);

    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RowItem(
          text: Text(title, style: _titleStyle),
          size: 20,
          child: TimerAnimation(expiry: time, size: 16),
        ),
      ),
    );
  }
}
