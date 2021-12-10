import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

class CountdownBanner extends StatelessWidget {
  const CountdownBanner({
    Key? key,
    required this.message,
    required this.time,
    this.color,
    this.margin = const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
  }) : super(key: key);

  final String message;
  final DateTime time;
  final Color? color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final l10n = NavisLocalizations.of(context)!;

    return Container(
      margin: margin,
      color: color,
      child: RowItem(
        text: Text(
          message,
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
        child: CountdownTimer(
          tooltip: l10n.countdownTooltip(time),
          size: 16,
          expiry: time,
        ),
      ),
    );
  }
}
