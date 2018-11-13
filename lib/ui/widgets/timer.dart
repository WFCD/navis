import 'dart:async';

import 'package:flutter/material.dart';

import '../animation/countdown.dart';

class Timer extends StatefulWidget {
  final Duration duration;
  final double size;
  final Future<Null> callback;
  final bool isMore1H;
  final bool isEvent;

  Timer(
      {this.duration,
      this.size,
      this.callback,
      this.isMore1H = false,
      this.isEvent = false});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> {
  Stream<Duration> timer;

  _hours(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 1))
      return Colors.green;
    else if (timeLeft < Duration(hours: 1) && timeLeft > Duration(minutes: 10))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  _days(Duration timeLeft) {
    if (timeLeft >= Duration(days: 1))
      return Colors.green;
    else if (timeLeft < Duration(days: 1) && timeLeft > Duration(hours: 20))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  Widget _timerVersions(Duration time) {
    final style = TextStyle(fontSize: widget.size, color: Colors.white);

    String days = '${time.inDays}';
    String hours = '${time.inHours % 24}';
    String minutes = '${(time.inMinutes % 60).floor()}'.padLeft(2, '0');
    String seconds = '${(time.inSeconds % 60).floor()}'.padLeft(2, '0');

    if (widget.isMore1H)
      return Text('$hours:$minutes:$seconds', style: style);
    else if (widget.isEvent)
      return Text('$days\d $hours:$minutes:$seconds', style: style);

    return Text('$minutes:$seconds', style: style);
  }

  @override
  void initState() {
    super.initState();
    timer = CounterScreenStream(widget.duration);
    timer.listen((d) {}, onDone: () => widget.callback);
  }

  @override
  void dispose() {
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      initialData: Duration(seconds: 60),
      stream: timer,
      builder: (context, snapshot) {
        Duration data = snapshot.data;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: widget.isEvent ? _days(data) : _hours(data),
              borderRadius: BorderRadius.circular(3.0)),
          child: _timerVersions(data),
        );
      },
    );
  }
}
