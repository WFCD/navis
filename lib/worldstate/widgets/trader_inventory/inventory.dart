import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class TraderItemView extends StatelessWidget {
  const TraderItemView({super.key, required this.traderItem});

  final TraderItem traderItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              traderItem.item,
              style: context.theme.textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16),
              child: _TraderItemTrailing(
                credits: traderItem.credits ?? 0,
                ducats: traderItem.ducats ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TraderItemTrailing extends StatelessWidget {
  const _TraderItemTrailing({
    required this.credits,
    required this.ducats,
  });

  final int credits;
  final int ducats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TrailingColumn(
            header: 'Credits',
            value: credits,
          ),
          const SizedBox(width: 25),
          _TrailingColumn(
            header: 'Ducats',
            value: ducats,
          ),
        ],
      ),
    );
  }
}

class _TrailingColumn extends StatelessWidget {
  const _TrailingColumn({required this.header, required this.value});

  final String header;
  final int value;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat();
    final textTheme = context.textTheme;
    final headerStyle =
        textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500);
    final valueStyle =
        textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(header, style: headerStyle),
        SizedBoxSpacer.spacerHeight6,
        Text(format.format(value), style: valueStyle),
      ],
    );
  }
}
