import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class Stats extends StatelessWidget {
  const Stats({super.key, required this.stats});

  final List<RowItem> stats;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (final stat in stats) {
      final index = stats.indexOf(stat);

      if (index == stats.length - 1) {
        children.add(stat);
      } else {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: stat,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
