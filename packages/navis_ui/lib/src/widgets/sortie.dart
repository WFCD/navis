import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/src/widgets/widgets.dart';
import 'package:wfcd_client/entities.dart';

class Sortie extends StatelessWidget {
  const Sortie({
    required this.faction,
    required this.boss,
    this.variants,
    this.missions,
    required this.timer,
  });

  final String faction;
  final String boss;
  final List<Variant>? variants;
  final List<Mission>? missions;
  final CountdownTimer timer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bossTextStlye = textTheme.headline6;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          ListTile(
            leading: FactionIcon(
              name: faction,
              // It's what worked for the style.
              // ignore: no-magic-number
              iconSize: 35,
            ),
            title: Text(boss, style: bossTextStlye),
            trailing: timer,
          ),
          if (variants != null)
            for (final variant in variants!) _Variant(variant: variant),
          if (missions != null)
            for (final mission in missions!) _Mission(mission: mission),
        ],
      ),
    );
  }
}

class _Variant extends StatelessWidget {
  const _Variant({required this.variant});

  final Variant variant;

  @override
  Widget build(BuildContext context) {
    final nodeMission = context.textTheme.subtitle1?.copyWith(fontSize: 15);
    final modifier = context.textTheme.caption?.copyWith(fontSize: 13);

    return ListTile(
      title: Text(
        '${variant.missionType} - ${variant.node}',
        style: nodeMission,
      ),
      subtitle: Text(variant.modifier, style: modifier),
    );
  }
}

class _Mission extends StatelessWidget {
  const _Mission({required this.mission});

  final Mission mission;

  @override
  Widget build(BuildContext context) {
    final nodeMission = context.textTheme.subtitle1?.copyWith(fontSize: 15);
    final modifier = context.textTheme.caption?.copyWith(fontSize: 13);
    final exclusiveWeapon = mission.exclusiveWeapon;

    return ListTile(
      title: Text(
        '${mission.type} - ${mission.node}',
        style: nodeMission,
      ),
      subtitle: exclusiveWeapon != null
          ? Text(exclusiveWeapon, style: modifier)
          : null,
    );
  }
}
