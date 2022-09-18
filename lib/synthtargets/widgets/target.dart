import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({super.key, required this.target});

  final SynthTarget target;

  void _onExpansionChanged(BuildContext context, {bool isExpanded = false}) {
    if (isExpanded) {
      Future<void>.delayed(
        kAnimationShort,
        () => Scrollable.ensureVisible(context, duration: kAnimationShort),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        key: PageStorageKey<String>(target.name),
        title: Text(target.name),
        textColor: NavisColors.secondary,
        // We want the smae color.
        // ignore: no-equal-arguments
        iconColor: NavisColors.secondary,
        onExpansionChanged: (b) => _onExpansionChanged(context, isExpanded: b),
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
