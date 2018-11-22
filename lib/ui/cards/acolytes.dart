import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../widgets/cards.dart';

class Acolytes extends StatelessWidget {
  Widget _buildAcolytes(PersistentEnemies enemy) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[acolyteProfile(enemy.agentType)]),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text('Acolyte: ${enemy.agentType}'),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                          'Health: ${(enemy.healthPercent * 100).toStringAsFixed(2)}\%'),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color:
                                enemy.isDiscovered ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: enemy.isDiscovered
                            ? Text('Located on: ${enemy.lastDiscoveredAt}')
                            : Text('Last seen on: ${enemy.lastDiscoveredAt}'))
                  ]),
                ),
              ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final enemies = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder<WorldState>(
      initialData: enemies.lastState,
      stream: enemies.worldstate,
      builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
        return Tiles(
            child: Column(
                children: snapshot.data.persistentEnemies
                    .map(_buildAcolytes)
                    .toList()));
      },
    );
  }
}

acolyteProfile(String acolyte) {
  switch (acolyte) {
    case 'Angst':
      return Image.asset('assets/acolytes/StrikerAcolyte.png', scale: 5.0);
      break;
    case 'Malice':
      return Image.asset('assets/acolytes/HeavyAcolyte.png', scale: 5.0);
      break;
    case 'Mania':
      return Image.asset('assets/acolytes/RogueAcolyte.png', scale: 5.0);
      break;
    case 'Misery':
      return Image.asset('assets/acolytes/AreaCasterAcolyte.png', scale: 5.0);
      break;
    case 'Torment':
      return Image.asset('assets/acolytes/ControlAcolyte.png', scale: 5.0);
      break;
    case 'Violence':
      return Image.asset('assets/acolytes/DuellistAcolyte.png', scale: 4.0);
      break;
  }
}
