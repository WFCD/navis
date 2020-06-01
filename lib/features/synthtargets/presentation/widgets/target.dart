import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({Key key, this.target}) : super(key: key);

  final SynthTarget target;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(target.name),
        children: target.locations.map<Widget>((l) {
          return ListTile(
            title: Text('${l.planet} (${l.mission})'),
            subtitle: Text('${l.type} | ${l.faction} | ${l.spawnRate}'),
          );
        }).toList(),
      ),
    );
  }
}
