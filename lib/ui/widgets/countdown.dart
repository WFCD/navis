import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';

import 'static_box.dart';

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
    final expiry = widget.expiry.toLocal();

    final start = expiry.difference(DateTime.now());

    _controller = AnimationController(
        vsync: this,
        duration:
            start < Duration.zero ? const Duration(milliseconds: 500) : start);

    _tween = StepTween(
        begin: expiry.millisecondsSinceEpoch,
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
      final expiry = widget.expiry.toLocal();
      final start = expiry.difference(DateTime.now().toUtc());

      _controller.duration =
          start < Duration.zero ? const Duration(milliseconds: 500) : start;

      _animation = StepTween(
              begin: expiry.millisecondsSinceEpoch,
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

  Widget _timerVersions(Duration time) {
    final String days = '${time.inDays}';
    final String hours = '${time.inHours % 24}';
    final String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    if (time < const Duration(days: 1))
      return Text('$hours:$minutes:$seconds',
          style: TextStyle(fontSize: size, color: Colors.white));
    else
      return Text('$days\d $hours:$minutes:$seconds',
          style: TextStyle(fontSize: size, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    final Duration duration = expiry.difference(DateTime.now());

    return StaticBox(
        color: _containerColors(duration), child: _timerVersions(duration));
  }
}
