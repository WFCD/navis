import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({Key? key, required this.target}) : super(key: key);

  final SynthTarget target;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        key: PageStorageKey<String>(target.name),
        title: Text(target.name),
        textColor: NavisColors.secondary,
        iconColor: NavisColors.secondary,
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
