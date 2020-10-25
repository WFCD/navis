import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';
import 'stats.dart';

class FrameStats extends StatelessWidget {
  const FrameStats({
    Key key,
    @required this.passive,
    @required this.category,
    @required this.health,
    @required this.shield,
    @required this.armor,
    @required this.power,
    this.sprintSpeed,
  }) : super(key: key);

  final String passive, category;
  final int health, shield, armor, power;
  final double sprintSpeed;

  Widget _passive(BuildContext context) {
    final textTheme = Theme.of(context)?.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Text('Passive', style: textTheme?.subtitle1),
          const SizedBox(height: 8.0),
          Text(
            passive,
            style: textTheme?.caption?.copyWith(fontStyle: FontStyle.italic),
          ),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (passive != null) _passive(context),
          CategoryTitle(title: category, addPadding: false),
          const SizedBox(height: 16.0),
          Stats(stats: <RowItem>[
            RowItem(
              text: const Text('Shield'),
              child: Text('$shield'),
            ),
            RowItem(
              text: const Text('Armor'),
              child: Text('$armor'),
            ),
            RowItem(
              text: const Text('Health'),
              child: Text('$health'),
            ),
            RowItem(
              text: const Text('Power'),
              child: Text('$power'),
            ),
            if (sprintSpeed != null)
              RowItem(
                text: const Text('Sprint Speed'),
                child: Text('$sprintSpeed'),
              ),
          ]),
        ],
      ),
    );
  }
}
