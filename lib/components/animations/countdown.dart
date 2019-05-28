import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:simple_animations/simple_animations.dart';

import '../layout/static_box.dart';

class CountdownBox extends StatefulWidget {
  const CountdownBox({this.expiry, this.size});

  final DateTime expiry;
  final double size;

  @override
  _CountdownBoxState createState() => _CountdownBoxState();
}

class _CountdownBoxState extends State<CountdownBox> {
  Duration duration;
  Tween tween;

  @override
  void initState() {
    super.initState();

    duration = widget.expiry.difference(DateTime.now());
    tween = StepTween(
        begin: widget.expiry.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    if (oldWidget.expiry != widget.expiry) {
      duration = widget.expiry.difference(DateTime.now());
      tween = StepTween(
          begin: widget.expiry.millisecondsSinceEpoch,
          end: DateTime.now().millisecondsSinceEpoch);
    }

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
      //delay: const Duration(milliseconds: 250),
      duration: duration,
      tween: tween,
      playback: Playback.PLAY_FORWARD,
      animationControllerStatusListener: (AnimationStatus status) =>
          _listener(context, status),
      builder: (context, value) {
        final Duration duration = widget.expiry.difference(DateTime.now());

        return StaticBox(
            color: _containerColors(duration),
            child: Text(_timerVersions(duration),
                style: TextStyle(fontSize: widget.size, color: Colors.white)));
      },
    );
  }
}
