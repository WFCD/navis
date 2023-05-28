import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

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
  late AnimationController _controller;
  late Animation<double> _animation;
  late Duration _remainingTime;

  bool _expired = false;
  Color _warningLevel = Colors.green;

  void _setupCountdown() {
    final expirationDate = widget.expiry.toLocal();
    final currentTime = DateTime.now();

    _remainingTime = expirationDate.difference(currentTime);
    if (_remainingTime <= Duration.zero) {
      _remainingTime = Duration(seconds: 60);
      _expired = true;
    }

    _controller = AnimationController(duration: _remainingTime, vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    if (widget.color == null) {
      _controller.addListener(_detectWarningLevel);
    }

    _controller
      ..addStatusListener(_onEnd)
      ..forward();
  }

  void _detectWarningLevel() {
    const max = Duration(minutes: 60);
    const minimum = Duration(minutes: 10);
    final remainingTime = _remainingTime * _animation.value;

    Color newLevel;
    if (remainingTime > max) {
      newLevel = Colors.green;
    } else if (remainingTime < max && remainingTime > minimum) {
      newLevel = Colors.orange[700]!;
    } else {
      newLevel = Colors.red;
    }

    if (context.mounted) {
      setState(() {
        _warningLevel = newLevel;
      });
    }
  }

  void _onEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        _controller
          ..removeListener(_detectWarningLevel)
          ..removeStatusListener(_onEnd)
          ..dispose();
        setState(_setupCountdown);
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
      _controller
        ..removeListener(_detectWarningLevel)
        ..removeStatusListener(_onEnd)
        ..dispose();
      setState(_setupCountdown);
    }
  }

  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    final is24hrs = duration < const Duration(days: 1);

    return '${_expired ? 'Expired: -' : ''}'
        '${!is24hrs ? '${days}d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    Color color = _warningLevel;

    if (widget.color != null) color = widget.color!;
    if (_expired) {
      color = theme.isLight
          ? theme.colorScheme.primary
          : theme.colorScheme.primaryContainer;
    }

    return ColoredContainer(
      tooltip: widget.tooltip,
      color: color,
      padding: widget.padding,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final remainingTime = _remainingTime * _animation.value;

          return Text(
            _formatDuration(remainingTime),
            style: widget.style?.copyWith(color: Colors.white) ??
                TextStyle(fontSize: widget.size, color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_detectWarningLevel)
      ..removeStatusListener(_onEnd)
      ..dispose();

    super.dispose();
  }
}
