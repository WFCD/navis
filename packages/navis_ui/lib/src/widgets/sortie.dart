import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/src/widgets/widgets.dart';

class SortieWidget extends StatelessWidget {
  const SortieWidget({
    super.key,
    required this.faction,
    required this.boss,
    required this.missions,
    required this.timer,
  });

  final String faction;
  final String boss;
  final List<SortieMission> missions;
  final CountdownTimer timer;

  @override
  Widget build(BuildContext context) {
    const iconSize = 35.0;
    final textTheme = Theme.of(context).textTheme;
    final bossTextStlye = textTheme.titleLarge;

    return ExpandableAppCard(
      key: PageStorageKey(boss),
      header: ListTile(
        leading: FactionIcon(
          name: faction,
          size: iconSize,
        ),
        title: Text(boss, style: bossTextStlye),
        trailing: timer,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: missions,
      ),
      onTap: (isExpanded) {
        if (isExpanded) {
          Future.delayed(Durations.medium1, () {
            if (context.mounted) {
              Scrollable.ensureVisible(context, duration: Durations.short4);
            }
          });
        }
      },
    );
  }
}

class SortieMission extends StatelessWidget {
  const SortieMission({
    super.key,
    required this.node,
    required this.objective,
    required this.modifier,
  });

  final String node;
  final String objective;
  final String? modifier;

  @override
  Widget build(BuildContext context) {
    final missionTextStyle =
        context.textTheme.titleMedium?.copyWith(fontSize: 15);
    final modifierTextStyle =
        context.textTheme.bodySmall?.copyWith(fontSize: 13);

    final subtitle =
        modifier != null ? Text(modifier!, style: modifierTextStyle) : null;

    return ListTile(
      title: Text('$objective - $node', style: missionTextStyle),
      subtitle: subtitle,
    );
  }
}
