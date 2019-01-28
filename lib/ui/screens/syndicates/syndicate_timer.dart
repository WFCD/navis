import 'package:flutter/material.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/countdown.dart';

class SyndicateTimer extends StatelessWidget {
  const SyndicateTimer({this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RowItem(
            text: 'Bounties expire in',
            size: 20,
            child: CountdownBox(expiry: time, size: 17.0)),
      ),
    );
  }
}
