import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/countdown.dart';

class OrbVallis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final utils = state.stateUtils;

    final style = TextStyle(
        fontSize: 15.0, color: Theme.of(context).textTheme.body1.color);

    return Tiles(
        child: StreamBuilder<WorldState>(
            initialData: WorldstateBloc.initworldstate,
            stream: state.worldstate,
            builder: (context, snapshot) {
              final vallis = snapshot.data.vallis;
              final padding = SizedBox(height: 8);
              final counter = Counter(vallis.timer);

              return Column(children: <Widget>[
                padding,
                Text(
                  'Orb Vallis Cycle',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).textTheme.body1.color),
                ),
                Divider(),
                padding,
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
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: vallis.isWarm
                                ? Colors.red
                                : Colors.blueAccent[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0))),
                        child: StreamBuilder(
                            initialData: Duration(seconds: 60),
                            stream: counter.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<Duration> snapshot) {
                              Duration data = snapshot.data;

                              String minutes =
                                  '${(data.inMinutes % 60).floor()}'
                                      .padLeft(2, '0');
                              String seconds =
                                  '${(data.inSeconds % 60).floor()}'
                                      .padLeft(2, '0');

                              return Text('$minutes:$seconds',
                                  style: TextStyle(color: Colors.white));
                            }),
                      )
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
