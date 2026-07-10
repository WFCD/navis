import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class Stat {
  Stat({required this.name, required this.value, this.isVisible = true});

  final Widget name;
  final Widget value;
  final bool isVisible;
}

class StatsColumn extends StatelessWidget {
  const StatsColumn({super.key, this.padding = const EdgeInsets.only(bottom: 16), required this.stats});

  final EdgeInsets padding;
  final List<Stat> stats;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (final stat in stats) {
      if (!stat.isVisible) continue;

      final index = stats.indexOf(stat);
      final child = RowItem(text: stat.name, child: stat.value);

      if (index == stats.length - 1) {
        children.add(child);
      } else {
        children.add(
          Padding(padding: padding, child: child),
        );
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
