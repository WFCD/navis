import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class TraderItemCard extends StatelessWidget {
  const TraderItemCard({super.key, required this.item});

  final TraderItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          dense: true,
          title: Text(item.item),
          trailing: _TraderItemTrailing(
            credits: item.credits ?? 0,
            ducats: item.ducats ?? 0,
          ),
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
        mainAxisSize: MainAxisSize.min,
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
    final textTheme = context.textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(
      color: context.theme.colorScheme.onSurfaceVariant,
    );

    final valueStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w800,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(header, style: headerStyle),
        SizedBoxSpacer.spacerHeight6,
        Text(NumberFormat().format(value), style: valueStyle),
      ],
    );
  }
}
