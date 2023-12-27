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
  }) : super(key: key);

  final String tooltip;
  final DateTime? expiry;
  final Color? color;
  final double? size;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Duration _remainingTime;

  bool _isExpired = false;
  Color _warningLevel = Colors.green;

  void _setupCountdown() {
    final expirationDate = widget.expiry?.toLocal();
    final now = DateTime.now();

    _remainingTime = expirationDate?.difference(now) ?? Duration(seconds: 60);
    if (_remainingTime <= Duration.zero) {
      _remainingTime = Duration(seconds: 60);
      _isExpired = true;
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
        _controller.dispose();
        setState(_setupCountdown);
      }
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
      _controller.dispose();
      _isExpired = false;
      setState(_setupCountdown);
    }
  }

  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    final is24hrs = duration < const Duration(days: 1);

    return '${_isExpired ? 'Expired:' : ''}'
        '${!is24hrs ? '${days}d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    Color color = _warningLevel;

    if (widget.color != null) color = widget.color!;
    if (_isExpired) {
      color = theme.isLight
          ? theme.colorScheme.primary
          : theme.colorScheme.primaryContainer;
    }

    TextStyle? style;
    if (widget.color == Colors.transparent) {
      style = widget.style;
    } else {
      style = widget.style?.copyWith(color: Colors.white);
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
            style:
                style ?? TextStyle(fontSize: widget.size, color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _isExpired = false;

    super.dispose();
  }
}
