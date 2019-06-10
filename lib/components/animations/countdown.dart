import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:simple_animations/simple_animations.dart';

import '../layout/static_box.dart';

class CountdownBox extends StatefulWidget {
  const CountdownBox(
      {@required this.expiry,
      this.color,
      this.size,
      this.padding = const EdgeInsets.all(4.0),
      this.margin = const EdgeInsets.all(3.0)});

  final DateTime expiry;
  final Color color;
  final double size;
  final EdgeInsetsGeometry padding, margin;

  @override
  _CountdownBoxState createState() => _CountdownBoxState();
}

class _CountdownBoxState extends State<CountdownBox> {
  Duration duration;
  Tween tween;

  Future<void> setupDuration() async {
    final duration = Duration(
        seconds: widget.expiry.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch);
    final tween = StepTween(
        begin: widget.expiry.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch);

    setState(() {
      this.duration = duration;
      this.tween = tween;
    });
  }

  @override
  void initState() {
    super.initState();
    setupDuration();
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    if (oldWidget.expiry != widget.expiry) setupDuration();

    super.didUpdateWidget(oldWidget);
  }

  Future<void> _listener(BuildContext context, AnimationStatus status) async {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    }
  }

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
    return ControlledAnimation(
      duration: duration,
      tween: tween,
      playback: Playback.PLAY_FORWARD,
      animationControllerStatusListener: (AnimationStatus status) =>
          _listener(context, status),
      builder: (context, value) {
        final duration = widget.expiry.difference(DateTime.now());

        return StaticBox(
            color: widget.color ?? _containerColors(duration),
            padding: widget.padding,
            margin: widget.margin,
            child: Text(_timerVersions(duration),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: widget.size, color: Colors.white)));
      },
    );
  }
}
