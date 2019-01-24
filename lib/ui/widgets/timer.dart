import 'package:flutter/material.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/blocs/provider.dart';

import 'static_box.dart';

//enum TimerLength { days, hours }

class Timer extends StatefulWidget {
  final DateTime expiry;
  final double size;

  Timer({this.expiry, this.size});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  int _currentTime;
  AnimationController _controller;
  Animation<int> _animation;
  StepTween _tween;

  _listener(AnimationStatus status) {
    if (_tween.end == _currentTime)
      BlocProvider.of<WorldstateBloc>(context).update();
  }

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now().millisecondsSinceEpoch;

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: (widget.expiry.millisecondsSinceEpoch - _currentTime)));

    _tween = StepTween(
        begin: widget.expiry.millisecondsSinceEpoch, end: _currentTime);

    _animation = _tween.animate(_controller)..addStatusListener(_listener);

    _controller.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(Timer oldWidget) {
    if (oldWidget.expiry != widget.expiry) {
      _currentTime = DateTime.now().millisecondsSinceEpoch;

      _controller.duration = Duration(
          seconds: (widget.expiry.millisecondsSinceEpoch - _currentTime));

      _tween.begin = widget.expiry.millisecondsSinceEpoch;
      _tween.end = _currentTime;
      _controller
        ..reset()
        ..forward(from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeStatusListener(_listener);
    _tween = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CountDown(
        animation: _animation, expiry: widget.expiry, size: widget.size);
  }
}

class CountDown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime expiry;
  final double size;

  CountDown({Key key, this.animation, this.expiry, this.size})
      : super(key: key, listenable: animation);

  _containerColors(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 1))
      return Colors.green;
    else if (timeLeft < Duration(hours: 1) && timeLeft > Duration(minutes: 10))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  String _timerVersions(Duration time) {
    final forDays = Duration(days: 1);

    String days = '${time.inDays}';
    String hours = '${time.inHours % 24}';
    String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    if (time < forDays)
      return '$hours:$minutes:$seconds';
    else
      return '$days\d $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = expiry.difference(DateTime.now());

    return StaticBox.text(
        color: _containerColors(duration),
        text: _timerVersions(duration),
        size: size);
  }
}
