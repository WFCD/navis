import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/countdown.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/routes/trader_inventory.dart';

class Trader extends StatefulWidget {
  @override
  _Trader createState() => _Trader();
}

class _Trader extends State<Trader> {
  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);
    final emptyBox = Container();

    return Tiles(
        title: 'Void Trader',
        child: BlocBuilder(
          bloc: wstate,
          builder: (context, state) {
            if (state is WorldstateLoaded) {
              final trader = state.worldState.trader;

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
                    child: StaticBox.text(
                      color: Colors.blueAccent[400],
                      text: trader.active
                          ? wstate.expiration(trader.expiry)
                          : wstate.expiration(trader.activation),
                    )),
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
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text('Baro Ki\'Teeer Inventory',
                                        style: TextStyle(fontSize: 17.0))
                                  ])))
                      : emptyBox,
                ),
              ]);
            }
          },
        ));
  }
}
