import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:worldstate_api_model/entities.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({Key key, @required this.sortie})
      : assert(sortie != null),
        super(key: key);

  final Sortie sortie;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final boss = textTheme.headline6;
    final nodeMission = textTheme.subtitle1.copyWith(fontSize: 15);
    final modifier = textTheme.caption.copyWith(fontSize: 13);

    return CustomCard(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            ListTile(
              leading: FactionIcon(
                faction: sortie.faction,
                iconSize: 35.0,
              ),
              title: Text(sortie.boss, style: boss),
              trailing: CountdownTimer(
                expiry: sortie?.expiry ??
                    DateTime.now().subtract(const Duration(seconds: 60)),
              ),
            ),
            for (final variant in sortie.variants)
              ListTile(
                title: Text('${variant.missionType} - ${variant.node}',
                    style: nodeMission),
                subtitle: Text(variant.modifier, style: modifier),
              )
          ]),
    );
  }
}
