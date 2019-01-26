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
        return Tiles(
            title: 'Acolytes',
            child: Column(
                children: snapshot.data.persistentEnemies
                    .map((e) => AcolyteProfile(enemy: e))
                    .toList()));
      },
    );
  }
}

class AcolyteProfile extends StatelessWidget {
  final PersistentEnemies enemy;

  AcolyteProfile({@required this.enemy});

  _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else if (health < 10.0) return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RowItem(
          text: 'Acolyte: ${enemy.agentType} | lvl: ${enemy.rank}',
          child: StaticBox.text(
              size: 15,
              text:
                  'Health: ${(enemy.healthPercent * 100).toStringAsFixed(2)}\%',
              color: _healthColor((enemy.healthPercent * 100)))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        StaticBox(
          color: enemy.isDiscovered ? Colors.red[800] : Colors.grey,
          child: Row(children: <Widget>[
            enemy.isDiscovered
                ? Icon(Icons.gps_fixed)
                : Icon(Icons.gps_not_fixed),
            SizedBox(width: 4),
            Text(enemy.lastDiscoveredAt)
          ]),
        ),
        StaticBox.text(
          color: enemy.isDiscovered ? Colors.red[800] : Colors.blueAccent[400],
          size: 15,
          text:
              '${enemy.isDiscovered ? 'Found' : 'Last seen'}: ${enemy.lastDiscoveredTime.difference(DateTime.now()).inMinutes.abs()}m ago',
        )
      ])
    ]);
  }
}
