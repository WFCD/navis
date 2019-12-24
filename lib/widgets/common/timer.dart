import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/bloc/bloc.dart';

import 'colored_container.dart';

class TimerAnimation extends StatefulWidget {
  const TimerAnimation({
    Key key,
    @required this.expiry,
    this.color,
    this.size,
    this.style,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
  })  : assert(expiry != null),
        super(key: key);

  final DateTime expiry;
  final Color color;
  final double size;
  final TextStyle style;
  final EdgeInsetsGeometry padding, margin;

  @override
  _TimerAnimationState createState() => _TimerAnimationState();
}

class _TimerAnimationState extends State<TimerAnimation>
    with TickerProviderStateMixin {
  bool _expired = false;

  Animation<int> _tween;
  Duration _duration;
  AnimationController _controller;

  void _setup() {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final _expiry = widget.expiry?.millisecondsSinceEpoch ?? now;

    _duration = Duration(seconds: _expiry - now).abs();

    _controller = AnimationController(duration: _duration, vsync: this)
      ..addStatusListener(_listener);

    _tween = StepTween(begin: _expiry, end: now).animate(_controller);

    _controller.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void didUpdateWidget(TimerAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    final _now = DateTime.now().toUtc();

    if (oldWidget.expiry != widget.expiry || oldWidget.expiry.isAfter(_now)) {
      _controller?.dispose();
      _setup();
    }
  }

  void _listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      BlocProvider.of<WorldstateBloc>(context).updateWorldstate();

      final expired = widget.expiry.isBefore(DateTime.now().toUtc());

      if (_expired != expired && mounted) {
        setState(() {
          _expired = expired;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _TimerAnimatedWidget(
      listenable: _tween,
      color: widget.color,
      margin: widget.margin,
      padding: widget.padding,
      style: widget.style,
      fontSize: widget.size,
      expired: _expired,
      expiry: widget.expiry,
    );
  }

  @override
  void dispose() {
    _controller?.removeStatusListener(_listener);
    _controller?.dispose();
    super.dispose();
  }
}

class _TimerAnimatedWidget extends AnimatedWidget {
  const _TimerAnimatedWidget({
    @required Animation<int> listenable,
    @required this.expiry,
    @required this.expired,
    this.margin,
    this.padding,
    this.color,
    this.style,
    this.fontSize,
  })  : assert(listenable != null),
        assert(expiry != null),
        assert(expired != null),
        super(listenable: listenable);

  final DateTime expiry;
  final double fontSize;
  final TextStyle style;
  final EdgeInsetsGeometry margin, padding;
  final Color color;
  final bool expired;

  String _timerVersions(Duration time, bool expired) {
    final String days = '${time.inDays}';
    final String hours = '${time.inHours % 24}';
    final String minutes = '${time.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${time.inSeconds % 60}'.padLeft(2, '0');

    final bool is24hrs = time < const Duration(days: 1);

    return "${expired ? 'Expired: -' : ''}${!is24hrs ? '$days\d' : ''} $hours:$minutes:$seconds";
  }

  Color _containerColors(
      BuildContext context, Duration timeLeft, bool expired) {
    const max = Duration(hours: 1);
    const minimum = Duration(minutes: 10);

    if (!expired) {
      if (timeLeft >= max) {
        return Colors.green;
      } else if (timeLeft <= max && timeLeft >= minimum) {
        return Colors.orange[700];
      } else {
        return Colors.red;
      }
    }

    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final remaining = expiry.difference(DateTime.now().toUtc()).abs();

    return ColoredContainer.text(
      fontSize: fontSize,
      style: style,
      margin: margin,
      padding: padding,
      text: _timerVersions(remaining, expired),
      color: color ?? _containerColors(context, remaining, expired),
    );
  }
}
