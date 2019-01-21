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

    final emptyBox = Container();

    return Tiles(
        title: 'Void Trader',
        child: StreamBuilder<WorldState>(
          initialData: WorldstateBloc.initworldstate,
          stream: state.worldstate,
          builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
            final trader = snapshot.data.trader;
            final style =
                Theme.of(context).textTheme.subhead.copyWith(fontSize: 17);

            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 5.0, left: 5.0, right: 3.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          snapshot.data.trader.active
                              ? Text('${trader.character} leaves in',
                                  style: style)
                              : Text('${trader.character} arrives in',
                                  style: style),
                          Timer(
                              expiry: trader.active
                                  ? trader.expiry
                                  : trader.activation)
                        ]),
                  ),
                  trader.active
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: 5.0, left: 5.0, right: 3.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Loaction', style: style),
                                Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent[400],
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
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
                                ? Text('Leaves on', style: style)
                                : Text('Arrives on', style: style),
                            Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent[400],
                                    borderRadius: BorderRadius.circular(3.0)),
                                child: trader.active
                                    ? Text(utils.expiration(trader.expiry),
                                        style: TextStyle(color: Colors.white))
                                    : Text(utils.expiration(trader.activation),
                                        style: TextStyle(color: Colors.white)))
                          ])),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 8.0, left: 5.0, right: 3.0),
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
                ]);
          },
        ));
  }
}
