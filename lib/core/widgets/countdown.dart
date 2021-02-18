import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../themes/colors.dart';
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
  static const _max = Duration(hours: 1);
  static const _minimum = Duration(minutes: 10);

  AnimationController _controller;
  bool _expired = false;
  Color _warningLevel = Colors.green;

  DateTime get _now => DateTime.now();
  DateTime get localExpiry => widget.expiry.toLocal();
  Duration get _timeLeft => _controller.duration * _controller?.value;

  void _setupCountdown() {
    _controller = AnimationController(
        duration: localExpiry.difference(_now).abs(), vsync: this);

    if (widget.color == null) {
      _expired = localExpiry.isBefore(_now);
      _controller.addListener(_detectWarningLevel);
    }

    _controller.addStatusListener(_onEnd);

    _controller.reverse(from: 1.0);
  }

  void _detectWarningLevel() {
    Color newLevel;

    if (_timeLeft > _max) {
      newLevel = Colors.green;
    } else if (_timeLeft < _max && _timeLeft > _minimum) {
      newLevel = Colors.orange[700];
    } else if (_timeLeft < _minimum) {
      newLevel = _expired ? primary : Colors.red;
    }

    if (mounted && _warningLevel != newLevel) {
      setState(() {
        _warningLevel = newLevel;
      });
    }
  }

  void _onEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      BlocProvider.of<SolsystemBloc>(context).update(forceUpdate: true);
    }

    if (mounted) {
      setState(() {
        _expired = localExpiry.isBefore(_now);
      });
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

    if (oldWidget.expiry != widget.expiry || _expired) {
      if (widget.color != Colors.transparent) {
        if (_controller != null) {
          _controller
            ..removeListener(_detectWarningLevel)
            ..removeStatusListener(_onEnd);
          _controller.dispose();
        }
      }

      _setupCountdown();
    }
  }

  String _timerVersions() {
    final String days = '${_timeLeft.inDays}';
    final String hours = '${_timeLeft.inHours % 24}';
    final String minutes = '${_timeLeft.inMinutes % 60}'.padLeft(2, '0');
    final String seconds = '${_timeLeft.inSeconds % 60}'.padLeft(2, '0');

    final bool is24hrs = _timeLeft < 1.days;

    return '${_expired ? 'Expired: -' : ''}${!is24hrs ? '$days\d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final endTime = localExpiry.format(context);

    return StaticBox(
      tooltip: context.locale.countdownTooltip(endTime),
      color: widget.color ?? _warningLevel,
      padding: widget.padding,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
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
    if (widget.color != Colors.transparent) {
      if (_controller != null) {
        _controller
          ..removeListener(_detectWarningLevel)
          ..removeStatusListener(_onEnd);
        _controller.dispose();
      }
    }

    super.dispose();
  }
}
