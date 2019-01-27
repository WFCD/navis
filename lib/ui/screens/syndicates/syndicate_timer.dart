import 'package:flutter/material.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/countdown.dart';

class SyndicateTimer extends StatelessWidget {
  final DateTime time;

  SyndicateTimer({this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: RowItem(
            text: 'Bounties expire in',
            size: 20,
            child: CountdownBox(expiry: time, size: 17.0)),
      ),
    );
  }
}
