import 'package:flutter/material.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

//enum TimerLength { days, hours }

class Timer extends StatefulWidget {
  final DateTime expiry;
  final double size;

  Timer({this.expiry, this.size});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> with TickerProviderStateMixin {
  final bloc = WorldstateBloc();
  AnimationController _controller;

  _setupAnimation() async {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: widget.expiry.millisecondsSinceEpoch -
                DateTime.now().millisecondsSinceEpoch));

    try {
      await _controller.forward(from: 0.0).orCancel;
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();
    _setupAnimation();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) rebuild();
    });
  }

  @override
  void didUpdateWidget(Timer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expiry != widget.expiry) {
      _controller.reset();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  void rebuild() {
    bloc.update();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CountDown(
        animation: StepTween(
                begin: widget.expiry.millisecondsSinceEpoch,
                end: DateTime.now().millisecondsSinceEpoch)
            .animate(_controller),
        expiry: widget.expiry,
        size: widget.size);
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

  Widget _timerVersions(Duration time) {
    final style = TextStyle(fontSize: size, color: Colors.white);
    final forDays = Duration(days: 1);

    String days = '${time.inDays}';
    String hours = '${time.inHours % 24}';
    String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    if (time < forDays) {
      return Text('$hours:$minutes:$seconds', style: style);
    } else {
      return Text('$days\d $hours:$minutes:$seconds', style: style);
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = expiry.difference(DateTime.now());

    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: _containerColors(duration),
            borderRadius: BorderRadius.circular(3.0)),
        child: _timerVersions(duration));
  }
}
