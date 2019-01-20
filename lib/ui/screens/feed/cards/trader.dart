import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/timer.dart';
import 'package:navis/ui/routes/trader_inventory.dart';

class Trader extends StatefulWidget {
  @override
  _Trader createState() => _Trader();
}

class _Trader extends State<Trader> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final utils = state.stateUtils;
    final style = TextStyle(color: Theme.of(context).textTheme.body2.color);

    final emptyBox = Container();

    return StreamBuilder<WorldState>(
      initialData: WorldstateBloc.initworldstate,
      stream: state.worldstate,
      builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
        final trader = snapshot.data.trader;

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
                            ? Text('${trader.character} leaves in',
                                style: TextStyle(fontSize: 17.0))
                            : Text('${trader.character} arrives in',
                                style: TextStyle(fontSize: 17.0)),
                        Timer(
                            duration: trader.active
                                ? utils.durationFormater(trader.expiry)
                                : utils.durationFormater(trader.activation))
                      ]),
                ),
                trader.active
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
                                      color: Colors.blueAccent[400],
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Text('${trader.location}'))
                            ]))
                    : emptyBox,
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8.0, left: 5.0, right: 3.0),
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
                                  ? Text(utils.expiration(trader.expiry),
                                      style: style)
                                  : Text(utils.expiration(trader.activation),
                                      style: style))
                        ])),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0, left: 5.0, right: 3.0),
                  child: trader.active
                      ? InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  maintainState: false,
                                  builder: (_) => VoidTraderInventory(
                                      inventory: trader.inventory))),
                          child: Container(
                              width: 500.0,
                              height: 30.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent[400],
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Baro Ki\'Teeer Inventory',
                                        style: TextStyle(fontSize: 17.0))
                                  ])))
                      : emptyBox,
                ),
              ]),
        );
      },
    );
  }
}
