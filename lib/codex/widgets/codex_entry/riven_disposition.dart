import 'package:flutter/material.dart';

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({super.key, required this.disposition});

  final int disposition;

  @override
  Widget build(BuildContext context) {
    const maxDisposition = 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int i = 0; i < maxDisposition; i++)
          _RivenDot(enable: i < disposition),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        constraints: const BoxConstraints.expand(width: 15, height: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
          color: enable ? color : Colors.transparent,
        ),
      ),
    );
  }
}
