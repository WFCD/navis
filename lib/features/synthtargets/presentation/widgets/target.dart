import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../constants/default_durations.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({Key? key, required this.target}) : super(key: key);

  final SynthTarget target;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        key: PageStorageKey<String>(target.name),
        title: Text(target.name),
        onExpansionChanged: (b) {
          if (b) {
            Future<void>.delayed(kAnimationShort).then((value) {
              Scrollable.ensureVisible(context, duration: kAnimationShort);
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
