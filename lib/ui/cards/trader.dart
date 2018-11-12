import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/trader.dart';
import 'package:navis/models/worldstate.dart';

import '../animation/countdown.dart';
import '../widgets/cards.dart';

class Trader extends StatefulWidget {
  @override
  _Trader createState() => _Trader();
}

class _Trader extends State<Trader> {
  @override
  Widget build(BuildContext context) {
    final trader = BlocProvider.of<WorldstateBloc>(context);
    final style = TextStyle(color: Theme
        .of(context)
        .textTheme
        .body2
        .color);

    final emptyBox = Container();

    return StreamBuilder<WorldState>(
      initialData: trader.lastState,
      stream: trader.worldstate,
      builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
        final arrives = DateTime.parse(snapshot.data.trader.activation)
            .difference(DateTime.now());
        final leaving = DateTime.parse(snapshot.data.trader.expiry)
            .difference(DateTime.now());

        return Tiles(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('Void Trader', style: TextStyle(fontSize: 20.0)),
                ),
                Divider(color: Theme.of(context).accentColor),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 3.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        snapshot.data.trader.active
                            ? Text(
                            '${snapshot.data.trader.character} leaves in',
                            style: TextStyle(fontSize: 17.0))
                            : Text(
                            '${snapshot.data.trader.character} arrives in',
                            style: TextStyle(fontSize: 17.0)),
                        Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(3.0)),
                          child: StreamBuilder<Duration>(
                              initialData: Duration(seconds: 60),
                              stream: CounterScreenStream(
                                  snapshot.data.trader.active
                                      ? leaving
                                      : arrives),
                              builder: (context, snapshot) {
                                Duration data = snapshot.data;

                                String days = '${data.inDays}';
                                String hour = '${data.inHours % 24}';
                                String minutes =
                                '${(data.inMinutes % 60).floor()}'
                                    .padLeft(2, '0');
                                String seconds =
                                '${(data.inSeconds % 60).floor()}'
                                    .padLeft(2, '0');

                                return Text('$days\d $hour:$minutes:$seconds',
                                    style: TextStyle(color: Colors.white));
                              }),
                        )
                      ]),
                ),
                snapshot.data.trader.active
                    ? Padding(
                    padding:
                    EdgeInsets.only(bottom: 5.0, left: 5.0, right: 3.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Loaction',
                              style: TextStyle(fontSize: 17.0)),
                          Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(3.0)),
                              child:
                              Text('${snapshot.data.trader.location}'))
                        ]))
                    : emptyBox,
                Padding(
                    padding:
                    EdgeInsets.only(bottom: 8.0, left: 5.0, right: 3.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          snapshot.data.trader.active
                              ? Text('Leaves on',
                              style: TextStyle(fontSize: 17.0))
                              : Text('Arrives on',
                              style: TextStyle(fontSize: 17.0)),
                          Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent[400],
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: snapshot.data.trader.active
                                  ? Text(trader.voidTraderDeparture,
                                  style: style)
                                  : Text(trader.voidTraderArrival,
                                  style: style))
                        ])),
                ListTile(
                    title: Text('Baro Ki\'Teeer Inventory'),
                    trailing: ButtonTheme(
                        child: FlatButton(
                          child: Text('See Inventory'),
                          onPressed: () =>
                              _showInventory(
                                  context, snapshot.data.trader.inventory),
                        )))
              ]),
        );
      },
    );
  }
}

Future<Null> _showInventory(BuildContext context, List<Inventory> items) async {
  return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text('Current Inventory'),
          content: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: ListBody(
                  children: items.map((i) {
                    return Container(child: ListTile(title: Text(i.item)));
                  }).toList())),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              textColor: Colors.blue,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
