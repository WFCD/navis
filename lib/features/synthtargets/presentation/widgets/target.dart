import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({Key key, this.target}) : super(key: key);

  final SynthTarget target;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(target.name),
        onExpansionChanged: (b) {
          if (b) {
            Future<void>.delayed(const Duration(milliseconds: 200))
                .then((value) {
              Scrollable.ensureVisible(context,
                  duration: const Duration(milliseconds: 200));
            });
          }
        },
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
