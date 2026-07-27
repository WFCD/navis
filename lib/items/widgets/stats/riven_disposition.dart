import 'dart:math';

import 'package:flutter/material.dart';

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({super.key, required this.disposition});

  final double disposition;

  static const _thresholds = [.5, .7, .9, 1.11, 1.31];

  @override
  Widget build(BuildContext context) {
    final rounded = (disposition * pow(10, 2)).roundToDouble() / pow(10, 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int i = 0; i < _thresholds.length; i++) _RivenDot(enable: _thresholds[i] <= rounded),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text('(${disposition.toStringAsFixed(2)}x)'),
        ),
      ],
    );
  }
}

class _RivenDot extends StatelessWidget {
  const _RivenDot({required this.enable});

  final bool enable;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    const size = Size.square(12);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox.fromSize(
        size: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
            color: enable ? color : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
