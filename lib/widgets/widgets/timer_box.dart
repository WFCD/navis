import 'package:flutter/material.dart';
import 'package:navis/widgets/animations.dart';

import 'package:navis/widgets/layout.dart';

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
            text: title,
            size: 20,
            child: CountdownBox(expiry: time, size: 17.0)),
      ),
    );
  }
}
