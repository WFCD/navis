import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

class CountdownBanner extends StatelessWidget {
  const CountdownBanner({
    super.key,
    required this.message,
    required this.time,
    this.color,
    this.margin = const EdgeInsets.all(4),
  });

  final String message;
  final DateTime time;
  final Color? color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      margin: margin,
      color: color,
      child: RowItem(
        text: Text(
          message,
          // It's what worked for the style.
          // ignore: no-magic-number
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
        child: CountdownTimer(
          tooltip: l10n.countdownTooltip(time),
          // It's what worked for the style.
          // ignore: no-magic-number
          size: 16,
          expiry: time,
        ),
      ),
    );
  }
}
