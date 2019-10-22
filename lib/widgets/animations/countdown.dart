import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/widgets/widgets/static_box.dart';
import 'package:simple_animations/simple_animations.dart';

class CountdownBox extends StatefulWidget {
  const CountdownBox({
    @required this.expiry,
    this.color,
    this.size,
    this.style,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
  });

  final DateTime expiry;
  final Color color;
  final double size;
  final TextStyle style;
  final EdgeInsetsGeometry padding, margin;

  @override
  _CountdownBoxState createState() => _CountdownBoxState();
}

class _CountdownBoxState extends State<CountdownBox> {
  Tween _tween;
  Duration _duration;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final _expiry = widget.expiry?.millisecondsSinceEpoch ?? now;

    _duration = Duration(seconds: _expiry - now).abs();
    _tween = StepTween(begin: _expiry, end: now);
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    final _now = DateTime.now().toUtc();

    if (oldWidget.expiry != widget.expiry || oldWidget.expiry.isAfter(_now)) {
      final now = _now.millisecondsSinceEpoch;
      final expiry = widget.expiry?.millisecondsSinceEpoch ?? now;

      _duration = Duration(seconds: expiry - now).abs();
      _tween = StepTween(begin: expiry, end: now);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _listener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      BlocProvider.of<WorldstateBloc>(context).add(UpdateEvent());
    }
  }

  Color _containerColors(Duration timeLeft, bool expired) {
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
    return ControlledAnimation(
      duration: _duration,
      tween: _tween,
      playback: Playback.PLAY_FORWARD,
      animationControllerStatusListener: _listener,
      builder: (context, value) {
        final duration = widget.expiry.difference(DateTime.now().toUtc()).abs();
        final expired = widget.expiry.isBefore(DateTime.now().toUtc());

        return StaticBox.text(
          fontSize: widget.size,
          style: widget.style,
          margin: widget.margin,
          padding: widget.padding,
          text: _timerVersions(duration, expired),
          color: widget.color ?? _containerColors(duration, expired),
        );
      },
    );
  }
}
