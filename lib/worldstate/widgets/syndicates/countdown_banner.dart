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
  final DateTime? time;
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
          style: Theme.of(context).textTheme.titleMedium,
        ),
        child: CountdownTimer(
          tooltip: l10n.countdownTooltip(time ?? DateTime.now()),
          expiry: time,
        ),
      ),
    );
  }
}
