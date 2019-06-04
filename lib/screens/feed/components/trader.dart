import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';

import 'trader_inventory.dart';

class Trader extends StatelessWidget {
  const Trader({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final emptyBox = Container();

    return Tiles(
        title: 'Void Trader',
        child: BlocBuilder(
          bloc: BlocProvider.of<WorldstateBloc>(context),
          builder: (BuildContext context, WorldStates state) {
            if (state is WorldstateLoaded) {
              final trader = state.trader;

              return Column(children: <Widget>[
                RowItem(
                    text: trader.active
                        ? '${trader.character} leaves in'
                        : '${trader.character} arrives in',
                    child: CountdownBox(
                        expiry:
                            trader.active ? trader.expiry : trader.activation)),
                trader.active
                    ? RowItem(
                        text: 'Loaction',
                        child: StaticBox.text(
                            color: Colors.blueAccent[400],
                            text: '${trader.location}'))
                    : emptyBox,
                RowItem(
                  text: trader.active ? 'Leaves on' : 'Arrives on',
                  child: trader.active
                      ? DateView(expiry: trader.expiry)
                      : DateView(expiry: trader.activation),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 3.0),
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Baro Ki\'Teeer Inventory',
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.white))
                                ]),
                          ))
                      : emptyBox,
                ),
              ]);
            }
          },
        ));
  }
}
