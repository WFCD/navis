import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.tooltip,
    required this.expiry,
    this.color,
    this.style,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(3),
  });

  final String tooltip;
  final DateTime? expiry;
  final Color? color;
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

    _remainingTime =
        expirationDate?.difference(now) ?? const Duration(seconds: 60);
    if (_remainingTime <= Duration.zero) {
      _remainingTime = const Duration(seconds: 60);
      _isExpired = true;
    }

    _controller = AnimationController(duration: _remainingTime, vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

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

    if (context.mounted) {
      setState(() {
        _warningLevel = switch (remainingTime) {
          >= max => Colors.green,
          < max && >= minimum => Colors.orange[700]!,
          < minimum when !_isExpired => Colors.red,
          _ => Theme.of(context).colorScheme.secondaryContainer
        };
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

    return '${!is24hrs ? '${days}d' : ''} $hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? _warningLevel;

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
            style: (widget.style ?? Theme.of(context).textTheme.labelLarge)
                ?.copyWith(color: Colors.white),
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
