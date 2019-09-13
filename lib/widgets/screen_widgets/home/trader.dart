import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets.dart';

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
          condition: (WorldStates previous, WorldStates current) {
            final previousTrader = previous.worldstate?.voidTrader;
            final currentTrader = previous.worldstate?.voidTrader;

            return previousTrader != currentTrader ?? false;
          },
          builder: (BuildContext context, WorldStates state) {
            final trader = state.worldstate?.voidTrader;

            return Column(children: <Widget>[
              RowItem(
                  text: Text(trader.active
                      ? '${trader.character} leaves in'
                      : '${trader.character} arrives in'),
                  child: CountdownBox(
                      expiry:
                          trader.active ? trader.expiry : trader.activation)),
              const SizedBox(height: 4.0),
              trader.active
                  ? RowItem(
                      text: const Text('Loaction'),
                      child: StaticBox.text(
                          color: Colors.blueAccent[400],
                          text: '${trader.location}'))
                  : emptyBox,
              const SizedBox(height: 4.0),
              RowItem(
                text: Text(trader.active ? 'Leaves on' : 'Arrives on'),
                child: trader.active
                    ? DateView(expiry: trader.expiry)
                    : DateView(expiry: trader.activation),
              ),
              trader.active
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 8.0),
                      child: InkWell(
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
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Baro Ki\'Teeer Inventory',
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.white))
                                ]),
                          )),
                    )
                  : emptyBox,
            ]);
          },
        ));
  }
}
