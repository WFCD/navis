import 'package:flutter/material.dart';

import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import 'static_box.dart';

class CountdownBox extends StatefulWidget {
  final DateTime expiry;
  final double size;

  CountdownBox({this.expiry, this.size});

  @override
  CountdownBoxState createState() => CountdownBoxState();
}

class CountdownBoxState extends State<CountdownBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  StepTween _tween;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: widget.expiry.difference(DateTime.now()));

    _tween = StepTween(
        begin: widget.expiry.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch);

    _animation = _tween.animate(_controller);

    _controller.forward(from: 0.0);

    _animation.addStatusListener((status) => status == AnimationStatus.completed
        ? BlocProvider.of<WorldstateBloc>(context).update()
        : null);
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    if (oldWidget.expiry != widget.expiry) {
      _controller.duration = Duration(
          seconds: (widget.expiry.millisecondsSinceEpoch -
              DateTime.now().millisecondsSinceEpoch));

      _animation = StepTween(
              begin: widget.expiry.millisecondsSinceEpoch,
              end: DateTime.now().millisecondsSinceEpoch)
          .animate(_controller);

      _controller
        ..reset()
        ..forward(from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
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
