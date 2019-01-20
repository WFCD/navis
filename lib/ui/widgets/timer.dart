import 'dart:async';
import 'package:flutter/material.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import 'countdown.dart';

enum TimerLength { days, hours }

class Timer extends StatefulWidget {
  final Duration duration;
  final double size;
  final Future<Null> callback;

  Timer({this.duration, this.size, this.callback});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> {
  final bloc = WorldstateBloc();
  Counter countdown;

  @override
  void initState() {
    super.initState();
    countdown = Counter(widget.duration);
    countdown.stream.listen((data) {}, onDone: onDone);
  }

  @override
  void dispose() {
    countdown = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(Timer oldWidget) {
    if (oldWidget.duration != widget.duration) {
      countdown = Counter(widget.duration);
      countdown.stream.listen((data) {}, onDone: onDone);
    }

    super.didUpdateWidget(oldWidget);
  }

  _containerColors(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 1))
      return Colors.green;
    else if (timeLeft < Duration(hours: 1) && timeLeft > Duration(minutes: 10))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  Widget _timerVersions(Duration time) {
    final style = TextStyle(fontSize: widget.size, color: Colors.white);
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

  void onDone() {
    bloc.update();
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: countdown.stream,
      builder: (context, snapshot) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: snapshot.hasData
                  ? _containerColors(snapshot.data)
                  : Colors.grey,
              borderRadius: BorderRadius.circular(3.0)),
          child: snapshot.hasData ? _timerVersions(snapshot.data) : Text(''),
        );
      },
    );
  }
}
