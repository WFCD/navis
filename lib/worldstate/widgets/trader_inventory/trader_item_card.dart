import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class TraderItemCard extends StatelessWidget {
  const TraderItemCard({super.key, required this.item, this.isVarzia = false});

  final TraderItem item;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          dense: true,
          title: Text(item.name),
          trailing: _TraderItemTrailing(credits: item.regularPrice, ducats: item.primePrice, isVarzia: isVarzia),
        ),
      ),
    );
  }
}

class _TraderItemTrailing extends StatelessWidget {
  const _TraderItemTrailing({required this.ducats, required this.credits, this.isVarzia = false});

  final int ducats;
  final int credits;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TrailingColumn(header: isVarzia ? 'Regal Aya' : 'Ducats', value: ducats),
          const SizedBox(width: 25),
          _TrailingColumn(header: isVarzia ? 'Aya' : 'Credits', value: credits),
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
    final headerStyle = textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onSurfaceVariant);

    final valueStyle = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(header, style: headerStyle),
        Gaps.gap6,
        Text(NumberFormat().format(value), style: valueStyle),
      ],
    );
  }
}
