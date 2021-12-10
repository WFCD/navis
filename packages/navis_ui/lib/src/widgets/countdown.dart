import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/app_colors.dart';
import 'package:navis_ui/src/widgets/app_container.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    Key? key,
    required this.tooltip,
    required this.expiry,
    this.color,
    this.size,
    this.style,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(3),
    this.onTimerEnd,
  }) : super(key: key);

  final String tooltip;
  final DateTime expiry;
  final Color? color;
  final double? size;
  final TextStyle? style;
  final EdgeInsetsGeometry padding, margin;
  final Future<void> Function()? onTimerEnd;

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer>
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
    const defaultTime = Duration(seconds: 60);
    final difference = _localExpiry.difference(_now);

    _expired = difference <= Duration.zero;
    _controller = AnimationController(
      duration: _expired ? defaultTime : difference,
      vsync: this,
    );

    if (widget.color == null) {
      _controller!.addListener(_detectWarningLevel);
    }

    _controller!
      ..addStatusListener(_onEnd)
      ..reverse(from: 1);
  }

  void _detectWarningLevel() {
    Color? newLevel;

    if (_timeLeft > _max) {
      newLevel = Colors.green;
    } else if (_timeLeft < _max && _timeLeft > _minimum) {
      newLevel = Colors.orange[700];
    } else if (_timeLeft < _minimum) {
      newLevel = _expired ? NavisColors.blue : Colors.red;
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

      widget.onTimerEnd?.call();
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

    final is24hrs = _timeLeft < const Duration(days: 1);

    return '${_expired ? 'Expired: -' : ''}'
        '${!is24hrs ? '${days}d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ColoredContainer(
      tooltip: widget.tooltip,
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
