import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/timer.dart';

class OrbVallis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final utils = state.stateUtils;

    final style = Theme.of(context).textTheme.subhead;

    return Tiles(
        title: 'Orb Vallis Cycle',
        child: StreamBuilder<WorldState>(
            initialData: WorldstateBloc.initworldstate,
            stream: state.worldstate,
            builder: (context, snapshot) {
              final vallis = snapshot.data.vallis;
              final padding = SizedBox(height: 8);

              return Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Current Temperature is ', style: style),
                      Container(
                        child: Text(vallis.isWarm ? 'Warm' : 'Cold',
                            style: TextStyle(
                                color: vallis.isWarm ? Colors.red : Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ]),
                padding,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          'Time till Temperature ${vallis.isWarm ? 'Increases' : 'drops'} ',
                          style: style),
                      Timer(expiry: vallis.expiry),
                    ]),
                padding,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    vallis.isWarm
                        ? Text('Winter is coming in ', style: style)
                        : Text('Warmer climate at ', style: style),
                    StaticBox(
                        color: Colors.blueAccent[400],
                        child: Text('${utils.expiration(vallis.expiry)}',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
                padding
              ]);
            }));
  }
}
