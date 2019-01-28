import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/static_box.dart';

class Acolytes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final enemies = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder<WorldState>(
      initialData: WorldstateBloc.initworldstate,
      stream: enemies.worldstate,
      builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
        final List<AcolyteProfile> acolytes = snapshot.data.persistentEnemies
            .map((e) => AcolyteProfile(enemy: e))
            .toList();

        for (int i = 0; i < acolytes.length; i++) {
          if (i == (acolytes.length - 1)) {
          } else
            acolytes[i].divider = true;
        }

        return Tiles(title: 'Acolytes', child: Column(children: acolytes));
      },
    );
  }
}

//ignore: must_be_immutable
class AcolyteProfile extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AcolyteProfile({@required this.enemy});

  final PersistentEnemies enemy;

  bool divider = false;

  Color _healthColor(num health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else
      return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      RowItem(
          text: 'Acolyte: ${enemy.agentType} | lvl: ${enemy.rank}',
          child: StaticBox.text(
              size: 15,
              text:
                  'Health: ${(enemy.healthPercent * 100).toStringAsFixed(2)}%',
              color: _healthColor(enemy.healthPercent * 100))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        enemy.lastDiscoveredAt.isEmpty
            ? Container()
            : StaticBox(
                color: enemy.isDiscovered ? Colors.red[800] : Colors.grey,
                child: Row(children: <Widget>[
                  enemy.isDiscovered
                      ? const Icon(Icons.gps_fixed, color: color)
                      : const Icon(Icons.gps_not_fixed, color: color),
                  const SizedBox(width: 4),
                  Text(enemy.lastDiscoveredAt,
                      style: const TextStyle(color: color))
                ]),
              ),
        StaticBox.text(
          color: enemy.isDiscovered ? Colors.red[800] : Colors.blueAccent[400],
          size: 15,
          text:
              '${enemy.isDiscovered ? 'Found' : 'Last seen'}: ${enemy.lastDiscoveredTime.difference(DateTime.now()).inMinutes.abs()}m ago',
        )
      ]),
      divider ? Divider(color: Colors.blueAccent[400]) : Container()
    ]));
  }
}
