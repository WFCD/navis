import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../animation/countdown.dart';
import '../model.dart';
import '../widgets/cards.dart';

class Trader extends StatefulWidget {
  @override
  _Trader createState() => _Trader();
}

class _Trader extends State<Trader> {
  @override
  Widget build(BuildContext context) {
    final emptyBox = Container(height: 0.0, width: 0.0);

    return ScopedModelDescendant<NavisModel>(
      builder: (BuildContext context, Widget child, NavisModel model) {
        final trader = model.trader;
        final arrives =
            DateTime.parse(trader.activation).difference(DateTime.now());
        final leaving =
            DateTime.parse(trader.expiry).difference(DateTime.now());

        return Tiles(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('Void Trader', style: TextStyle(fontSize: 20.0)),
                ),
                Divider(color: Theme.of(context).accentColor),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        trader.active
                            ? Text('${trader.character} arrives in',
                                style: TextStyle(fontSize: 17.0))
                            : Text('${trader.character} leaves in',
                                style: TextStyle(fontSize: 17.0)),
                        Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(3.0)),
                          child: StreamBuilder<Duration>(
                              initialData: Duration(seconds: 60),
                              stream: CounterScreenStream(
                                  trader.active ? leaving : arrives),
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
                trader.active
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
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
                                  child: Text('${trader.location}'))
                            ]))
                    : emptyBox,
                Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          trader.active
                              ? Text('Leaves on',
                                  style: TextStyle(fontSize: 17.0))
                              : Text('Arrives on',
                                  style: TextStyle(fontSize: 17.0)),
                          Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent[400],
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: trader.active
                                  ? Text(model.departure)
                                  : Text(model.arrival))
                        ]))
              ]),
        );
      },
    );
  }
}
