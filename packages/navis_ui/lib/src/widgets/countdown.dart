import 'package:flutter/material.dart';

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

class CountdownTimerState extends State<CountdownTimer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Duration _remainingTime;

  Animation<Color?>? _bgColor;
  bool _isExpired = false;

  void _setupCountdown() {
    final expiry = widget.expiry;
    final now = DateTime.timestamp();

    _remainingTime = expiry?.difference(now) ?? const Duration(seconds: 60);
    _isExpired = _remainingTime <= Duration.zero;

    if (_isExpired) _remainingTime = const Duration(seconds: 60);

    _controller = AnimationController(duration: _remainingTime, vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

    if (widget.color == null) {
      _bgColor = _isExpired ? null : TweenSequence(_buildSequence(_remainingTime)).animate(_controller);
    }

    _controller
      ..addStatusListener(_onEnd)
      ..forward();
  }

  List<TweenSequenceItem<Color?>> _buildSequence(Duration remainingTime) {
    const max = Duration(minutes: 60);
    const minimum = Duration(minutes: 10);

    const weight = 1.0;
    const high = Colors.green;
    final mid = Colors.orange[700];
    const low = Colors.red;

    final sequence = <TweenSequenceItem<Color?>>[];

    if (remainingTime >= max) {
      sequence.add(
        TweenSequenceItem(
          weight: weight,
          tween: ColorTween(begin: high, end: mid),
        ),
      );
    }

    if (remainingTime < max && remainingTime >= minimum || remainingTime >= max) {
      sequence.add(
        TweenSequenceItem(
          weight: weight,
          tween: ColorTween(begin: mid, end: low),
        ),
      );
    }

    if (remainingTime < minimum) {
      sequence.add(TweenSequenceItem(weight: weight, tween: ConstantTween(low)));
    }

    return sequence;
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
    return Material(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4)),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final remainingTime = _remainingTime * _animation.value;

          return ColoredBox(
            // _bgColor won't be null if widget.color is not present
            color: widget.color ?? _bgColor?.value ?? Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                _formatDuration(remainingTime),
                style: (widget.style ?? Theme.of(context).textTheme.labelLarge)?.copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
