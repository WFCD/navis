import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../../l10n/l10n.dart';
import '../themes/colors.dart';
import '../utils/helper_methods.dart';
import 'static_box.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    required this.expiry,
    this.color,
    this.size,
    this.style,
    this.padding = const EdgeInsets.all(4.0),
    this.margin = const EdgeInsets.all(3.0),
  });

  final DateTime expiry;
  final Color? color;
  final double? size;
  final TextStyle? style;
  final EdgeInsetsGeometry padding, margin;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  static const _max = Duration(hours: 1);
  static const _minimum = Duration(minutes: 10);

  AnimationController? _controller;

  bool _expired = false;
  Color _warningLevel = Colors.green;

  DateTime get _now => DateTime.now();
  DateTime get _localExpiry => widget.expiry.toLocal();
  Duration get _timeLeft => _controller!.duration! * _controller!.value;

  void _setupCountdown() {
    final difference = _localExpiry.difference(_now);

    _expired = difference <= Duration.zero;
    _controller = AnimationController(
        duration: _expired ? 59.seconds : difference, vsync: this);

    if (widget.color == null) {
      _controller!.addListener(_detectWarningLevel);
    }

    _controller!
      ..addStatusListener(_onEnd)
      ..reverse(from: 1.0);
  }

  void _detectWarningLevel() {
    Color? newLevel;

    if (_timeLeft > _max) {
      newLevel = Colors.green;
    } else if (_timeLeft < _max && _timeLeft > _minimum) {
      newLevel = Colors.orange[700]!;
    } else if (_timeLeft < _minimum) {
      newLevel = _expired ? primary : Colors.red;
    }

    if (mounted && _warningLevel != newLevel!) {
      setState(() {
        _warningLevel = newLevel!;
      });
    }
  }

  void _onEnd(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      if (mounted) {
        if (_controller != null) {
          _controller!
            ..removeListener(_detectWarningLevel)
            ..removeStatusListener(_onEnd)
            ..dispose();
          setState(_setupCountdown);
        }
      }

      BlocProvider.of<SolsystemBloc>(context).update(forceUpdate: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCountdown();
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expiry != widget.expiry) {
      if (_controller != null) {
        _controller!
          ..removeListener(_detectWarningLevel)
          ..removeStatusListener(_onEnd)
          ..dispose();
        setState(_setupCountdown);
      }
    }
  }

  String _timerVersions() {
    final days = '${_timeLeft.inDays}';
    final hours = '${_timeLeft.inHours % 24}';
    final minutes = '${_timeLeft.inMinutes % 60}'.padLeft(2, '0');
    final seconds = '${_timeLeft.inSeconds % 60}'.padLeft(2, '0');

    final is24hrs = _timeLeft < 1.days;

    return '${_expired ? 'Expired: -' : ''}'
        '${!is24hrs ? '$days\d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final endTime = _localExpiry.format(context);

    return StaticBox(
      tooltip: context.l10n.countdownTooltip(endTime),
      color: widget.color ?? _warningLevel,
      padding: widget.padding,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (BuildContext context, Widget? child) {
          return Text(
            _timerVersions(),
            style: widget.style?.copyWith(color: Colors.white) ??
                TextStyle(fontSize: widget.size, color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!
        ..removeListener(_detectWarningLevel)
        ..removeStatusListener(_onEnd)
        ..dispose();
    }

    super.dispose();
  }
}
