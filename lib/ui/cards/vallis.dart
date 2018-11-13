import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/ui/animation/countdown.dart';

import '../widgets/cards.dart';

class OrbVallis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    final style = TextStyle(
        fontSize: 15.0, color: Theme.of(context).textTheme.body1.color);

    final isWarm = state.lastState.vallis.isWarm;

    return Tiles(
        child: Column(children: <Widget>[
      Text(
        'Orb Vallis Cycle',
        style: TextStyle(
            fontSize: 20.0, color: Theme.of(context).textTheme.body1.color),
      ),
      Divider(),
      Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Current Temperature is ', style: style),
                Container(
                  child: Text(isWarm ? 'Warm' : 'Cold',
                      style: TextStyle(
                          color: isWarm ? Colors.red : Colors.blue,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                )
              ])),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Time till Temperature ${isWarm ? 'Increases' : 'drops'} ',
                  style: style),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: isWarm ? Colors.red : Colors.blueAccent[400],
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
                child: StreamBuilder(
                    initialData: Duration(seconds: 60),
                    stream: CounterScreenStream(state.vallisCycleTime),
                    builder: (BuildContext context,
                        AsyncSnapshot<Duration> snapshot) {
                      Duration data = snapshot.data;

                      String minutes =
                          '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
                      String seconds =
                          '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

                      return Text('$minutes:$seconds',
                          style: TextStyle(color: Colors.white));
                    }),
              )
            ]),
      ),
      Container(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            isWarm
                ? Text('Winter is coming in ', style: style)
                : Text('Warmaer climate in ', style: style),
            Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.blueAccent[400],
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
                child: Text('${state.vallisExpiry}',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      )
    ]));
  }
}
