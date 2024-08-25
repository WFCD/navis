import 'package:flutter/material.dart';
import 'package:warframestat_client/warframestat_client.dart';

class TargetInfo extends StatelessWidget {
  const TargetInfo({super.key, required this.target});

  final SynthTarget target;

  void _onExpansionChanged(BuildContext context, {bool isExpanded = false}) {
    if (isExpanded) {
      Future<void>.delayed(
        kThemeAnimationDuration,
        () {
          if (!context.mounted) return;

          Scrollable.ensureVisible(
            context,
            duration: kThemeAnimationDuration,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        key: PageStorageKey<String>(target.name),
        shape: const Border(),
        title: Text(target.name),
        // textColor: NavisColors.secondary,
        // iconColor: NavisColors.secondary,
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
