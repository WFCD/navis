import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key, required this.stats}) : super(key: key);

  final List<RowItem> stats;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (final stat in stats) {
      final index = stats.indexOf(stat);

      if (index == stats.length - 1) {
        children.add(stat);
      } else {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: stat,
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
