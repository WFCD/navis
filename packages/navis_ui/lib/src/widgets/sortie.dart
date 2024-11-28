import 'package:flutter/material.dart';
import 'package:navis_ui/src/widgets/widgets.dart';

const _iconSize = 30.0;

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
    final textTheme = Theme.of(context).textTheme;
    final bossTextStlye = textTheme.titleLarge;

    return AppCard(
      child: ListTile(
        leading: FactionIcon(
          name: faction,
          size: _iconSize,
        ),
        title: Text(boss, style: bossTextStlye),
        trailing: timer,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) {
              return _SortieSheetContent(
                faction: faction,
                boss: boss,
                missions: missions,
                timer: timer,
              );
            },
          );
        },
      ),
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
    return ListTile(
      title: Text('$objective - $node'),
      subtitle: modifier != null ? Text(modifier!) : null,
    );
  }
}

class _SortieSheetContent extends StatelessWidget {
  const _SortieSheetContent({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: FactionIcon(
            name: faction,
            size: _iconSize,
          ),
          title: Text(boss),
          trailing: timer,
        ),
        ...missions,
      ],
    );
  }
}
