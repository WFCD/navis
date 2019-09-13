import 'package:flutter/material.dart';
import 'package:navis/widgets/widgets.dart';

class WarframeStats extends StatelessWidget {
  const WarframeStats({
    Key key,
    this.health,
    this.shield,
    this.armor,
    this.power,
    this.sprintSpeed,
    this.passive,
  }) : super(key: key);

  final num health, shield, armor, power, sprintSpeed;
  final String passive;

  Widget _passive(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Text('Passive', style: Theme.of(context).textTheme.subhead),
          const SizedBox(height: 8.0),
          Text(
            passive,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontStyle: FontStyle.italic),
          ),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(height: 16.0);

    return Tiles(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _passive(context),
          RowItem(text: const Text('Shield'), child: Text('$shield')),
          padding,
          RowItem(text: const Text('Armor'), child: Text('$armor')),
          padding,
          RowItem(text: const Text('Health'), child: Text('$health')),
          padding,
          RowItem(text: const Text('Power'), child: Text('$power')),
          padding,
          RowItem(
              text: const Text('Sprint Speed'), child: Text('$sprintSpeed')),
          padding
        ],
      ),
    );
  }
}
