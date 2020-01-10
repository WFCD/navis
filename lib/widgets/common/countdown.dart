import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';

import 'static_box.dart';

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

class _CountdownBoxState extends State<CountdownBox>
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
  void didUpdateWidget(CountdownBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    final _now = DateTime.now().toUtc();

    if (oldWidget.expiry != widget.expiry || oldWidget.expiry.isAfter(_now)) {
      _controller?.dispose();
      _setup();
    }
  }

  void _listener(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      Future.delayed(
        const Duration(seconds: 1),
        () => BlocProvider.of<WorldstateBloc>(context).update(),
      );

      setState(() {
        _expired = widget.expiry.isBefore(DateTime.now().toUtc());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CountDown(
      listenable: _tween,
      expiry: widget.expiry,
      expired: _expired,
      color: widget.color,
      margin: widget.margin,
      padding: widget.padding,
      style: widget.style,
      fontSize: widget.size,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class _CountDown extends AnimatedWidget {
  const _CountDown({
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
        assert(fontSize == null || style == null,
            'Use fontSize parameter if you\'re going to use a TextStyle'),
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
      if (timeLeft >= max)
        return Colors.green;
      else if (timeLeft < max && timeLeft > minimum)
        return Colors.orange[700];
      else
        return Colors.red;
    }

    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final duration = expiry.difference(DateTime.now().toUtc()).abs();

    return StaticBox.text(
      fontSize: fontSize,
      style: style,
      margin: margin,
      padding: padding,
      text: _timerVersions(duration, expired),
      color: color ?? _containerColors(context, duration, expired),
    );
  }
}
