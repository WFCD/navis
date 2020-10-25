import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

class Stats extends StatelessWidget {
  const Stats({Key key, @required this.stats}) : super(key: key);

  final List<RowItem> stats;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    stats.forEach((element) {
      final index = stats.indexOf(element);

      if (index == stats.length - 1) {
        children.add(element);
      } else {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: element,
        ));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
