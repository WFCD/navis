import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';
import 'package:navis/utils/extensions.dart';

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
  AnimationController _controller;
  Animation<int> _tween;

  Color _warningLevel = Colors.green;

  DateTime get _now => DateTime.now();
  DateTime get localExpiry => widget.expiry.toLocal();

  bool get _expired => localExpiry.isBefore(_now);
  Duration get _timeLeft => localExpiry.difference(_now);

  void _setupCountdown() {
    final begin = _expired
        ? _now.millisecondsSinceEpoch
        : localExpiry.millisecondsSinceEpoch;

    final end = _expired
        ? localExpiry.millisecondsSinceEpoch
        : _now.millisecondsSinceEpoch;

    _controller = AnimationController(
        duration: localExpiry.difference(_now).abs(), vsync: this);

    _tween = StepTween(begin: begin, end: end).animate(_controller);

    if (widget.color != Colors.transparent) {
      _tween.addListener(_detectWarningLevel);
    }
    _tween.addStatusListener(_onEnd);

    _controller.forward();
  }

  void _detectWarningLevel() {
    const max = Duration(hours: 1);
    const minimum = Duration(minutes: 10);

    Color newLevel;

    if (!_expired) {
      if (_timeLeft > max) {
        newLevel = Colors.green;
      } else if (_timeLeft < max && _timeLeft > minimum) {
        newLevel = Colors.orange[700];
      } else {
        newLevel = Colors.red;
      }
    } else {
      newLevel = Theme.of(context).primaryColor;
    }

    if (_warningLevel == newLevel) return;

    if (mounted) {
      setState(() {
        _warningLevel = newLevel;
      });
    }
  }

  String _timerVersions() {
    final String days = '${_timeLeft.inDays}';
    final String hours = '${_timeLeft.inHours % 24}';
    final String minutes = '${_timeLeft.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${_timeLeft.inSeconds % 60}'.padLeft(2, '0');

    final bool is24hrs = _timeLeft < const Duration(days: 1);

    return "${_expired ? 'Expired: -' : ''}${!is24hrs ? '$days\d' : ''} $hours:$minutes:$seconds";
  }

  void _onEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.delayed(
        const Duration(milliseconds: 700),
        () => context.bloc<WorldstateBloc>().add(UpdateEvent()),
      );

      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCountdown();
  }

  @override
  void didUpdateWidget(CountdownBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expiry != widget.expiry || _expired) {
      if (widget.color != Colors.transparent) {
        _tween?.removeListener(_detectWarningLevel);
      }
      _tween?.removeStatusListener(_onEnd);
      _controller?.dispose();
      _tween = null;
      _setupCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);
    final endTime = localExpiry.format(Intl.getCurrentLocale());

    return Tooltip(
      message: localizations.countdownTooltip(endTime),
      child: StaticBox(
        color: widget.color ?? _warningLevel,
        padding: widget.padding,
        margin: widget.margin,
        child: AnimatedBuilder(
          animation: _tween,
          builder: (BuildContext context, Widget child) {
            return Text(
              _timerVersions(),
              style: widget.style?.copyWith(color: Colors.white) ??
                  TextStyle(fontSize: widget.size, color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.color != Colors.transparent) {
      _tween?.removeListener(_detectWarningLevel);
    }
    _tween?.removeStatusListener(_onEnd);
    _controller?.dispose();
    super.dispose();
  }
}
