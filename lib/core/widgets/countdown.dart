import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/l10n/localizations.dart';

import '../utils/extensions.dart';
import 'static_box.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
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
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
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
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expiry != widget.expiry ||
        oldWidget.expiry.isAfter(DateTime.now().toUtc())) {
      _controller?.dispose();
      _setup();
    }
  }

  Future<void> _listener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future<void>.delayed(
        const Duration(seconds: 1),
        BlocProvider.of<SolsystemBloc>(context).update,
      );

      final expired = widget.expiry.isBefore(DateTime.now().toUtc());

      if (expired != _expired) {
        setState(() {
          _expired = expired;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = NavisLocalizations.of(context);

    return Tooltip(
      message: localization.countdownTooltip(widget.expiry.format(context)),
      child: _CountdownAnimation(
        listenable: _tween,
        expiry: widget.expiry,
        expired: _expired,
        color: widget.color,
        margin: widget.margin,
        padding: widget.padding,
        style: widget.style,
        fontSize: widget.size,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class _CountdownAnimation extends AnimatedWidget {
  const _CountdownAnimation({
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
      if (timeLeft >= max) {
        return Colors.green;
      } else if (timeLeft <= max && timeLeft > minimum) {
        return Colors.orange[700];
      } else {
        return Colors.red;
      }
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
