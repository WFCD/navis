import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
//import 'package:navis/utils/notifications.dart';

import '../layout/static_box.dart';

const stalling = Duration(milliseconds: 500);

class CountdownBox extends StatefulWidget {
  const CountdownBox({this.expiry, this.size});

  final DateTime expiry;
  final double size;

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
    //final notify = Notifications();
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    final expiry = widget.expiry.toLocal();
    final now = DateTime.now();
    final start = expiry.difference(now);

    _controller = AnimationController(
        vsync: this, duration: start < Duration.zero ? stalling : start);

    _tween = StepTween(
        begin: expiry.millisecondsSinceEpoch, end: now.millisecondsSinceEpoch);

    _animation = _tween.animate(_controller);

    _controller.forward(from: 0.0);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        bloc.update();
      }
    });
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    if (oldWidget.expiry != widget.expiry) {
      final expiry = widget.expiry.toLocal();
      final now = DateTime.now();

      final start = expiry.difference(now);

      _controller.duration = start < Duration.zero ? stalling : start;

      _tween = StepTween(
          begin: expiry.millisecondsSinceEpoch,
          end: now.millisecondsSinceEpoch);

      _animation = _tween.animate(_controller);

      _controller
        ..reset()
        ..forward(from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CountDown(
        animation: _animation, expiry: widget.expiry, size: widget.size);
  }
}

class _CountDown extends AnimatedWidget {
  const _CountDown({Key key, this.animation, this.expiry, this.size})
      : super(key: key, listenable: animation);

  final Animation<int> animation;
  final DateTime expiry;
  final double size;

  Color _containerColors(Duration timeLeft) {
    const max = Duration(hours: 1);
    const minimum = Duration(minutes: 10);

    if (timeLeft >= max)
      return Colors.green;
    else if (timeLeft < max && timeLeft > minimum)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  String _timerVersions(Duration time) {
    final String days = '${time.inDays}';
    final String hours = '${time.inHours % 24}';
    final String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    if (time < const Duration(days: 1))
      return '$hours:$minutes:$seconds';
    else
      return '$days\d $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final Duration duration = expiry.difference(DateTime.now());

    return StaticBox(
        color: _containerColors(duration),
        child: Text(_timerVersions(duration),
            style: TextStyle(fontSize: size, color: Colors.white)));
  }
}
