import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:simple_animations/simple_animations.dart';

import '../layout/static_box.dart';

class CountdownBox extends StatelessWidget {
  const CountdownBox({
    @required this.expiry,
    this.color,
    this.size,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
  });

  final DateTime expiry;
  final Color color;
  final double size;
  final EdgeInsetsGeometry padding, margin;

  Future<void> _listener(BuildContext context, AnimationStatus status) async {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    }
  }

  Color _containerColors(
    BuildContext context,
    Duration timeLeft,
    bool expired,
  ) {
    const max = Duration(hours: 1);
    const minimum = Duration(minutes: 10);

    if (!expired) {
      if (timeLeft >= max)
        return Colors.green;
      else if (timeLeft < max && timeLeft > minimum)
        return Colors.orange[700];
      else
        return Colors.red;
    }

    return Theme.of(context).primaryColor;
  }

  String _timerVersions(Duration time, bool expired) {
    final String days = '${time.inDays}';
    final String hours = '${time.inHours % 24}';
    final String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    final bool is24hrs = time < const Duration(days: 1);

    return "${expired ? 'Expired: -' : ''}${!is24hrs ? '$days\d' : ''} $hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();

    final duration = Duration(
            seconds: expiry.millisecondsSinceEpoch - now.millisecondsSinceEpoch)
        .abs();
    final tween = StepTween(
        begin: expiry.millisecondsSinceEpoch, end: now.millisecondsSinceEpoch);

    return ControlledAnimation(
      duration: duration,
      tween: tween,
      playback: Playback.PLAY_FORWARD,
      animationControllerStatusListener: (AnimationStatus status) =>
          _listener(context, status),
      builder: (context, value) {
        final duration = expiry.difference(DateTime.now().toUtc()).abs();
        final expired = expiry.isBefore(DateTime.now().toUtc());

        return StaticBox.text(
          size: size,
          margin: margin,
          padding: padding,
          text: _timerVersions(duration, expired),
          color: color ?? _containerColors(context, duration, expired),
        );
      },
    );
  }
}
