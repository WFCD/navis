import 'package:flutter/material.dart';
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Bounties expire in',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).textTheme.body1.color)),
              CountdownBox(expiry: time, size: 17.0)
            ]),
      ),
    );
  }
}
