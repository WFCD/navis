import 'dart:async';

import 'package:flutter/material.dart';

import '../animation/countdown.dart';

class Timer extends StatelessWidget {
  final Duration duration;
  final double size;
  final Future<Null> callback;

  Timer({this.duration, this.size, this.callback});

  _hours(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 1))
      return Colors.green;
    else if (timeLeft < Duration(hours: 1) && timeLeft > Duration(minutes: 10))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  Widget _timerVersions(Duration time) {
    final style = TextStyle(fontSize: size, color: Colors.white);
    final forDays = Duration(days: 1);

    String days = '${time.inDays}';
    String hours = '${time.inHours % 24}';
    String minutes = '${(time.inMinutes % 60).floor()}'.padLeft(2, '0');
    String seconds = '${(time.inSeconds % 60).floor()}'.padLeft(2, '0');

    if (time < forDays) {
      return Text('$hours:$minutes:$seconds', style: style);
    } else {
      return Text('$days\d $hours:$minutes:$seconds', style: style);
    }
  }

  @override
  Widget build(BuildContext context) {
    final countdown = CountDown(duration);
    return StreamBuilder<Duration>(
      initialData: Duration(seconds: 60),
      stream: countdown.stream,
      builder: (context, snapshot) {
        Duration data = snapshot.data;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: _hours(data), borderRadius: BorderRadius.circular(3.0)),
          child: snapshot.hasData ? _timerVersions(data) : Text(''),
        );
      },
    );
  }
}
