import 'package:flutter/material.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class VoidTraderPanel extends StatelessWidget {
  const VoidTraderPanel({Key key, this.trader}) : super(key: key);

  final VoidTrader trader;

  @override
  Widget build(BuildContext context) {
    final emptyBox = Container();
    final title = Theme.of(context).textTheme.subhead;

    return Tiles(
        title: 'Void Trader',
        child: Column(children: <Widget>[
          RowItem(
              text: Text(
                trader.active
                    ? '${trader.character} leaves in'
                    : '${trader.character} arrives in',
                style: title,
              ),
              child: CountdownBox(
                  expiry: trader.active ? trader.expiry : trader.activation)),
          const SizedBox(height: 4.0),
          trader.active
              ? RowItem(
                  text: Text('Loaction', style: title),
                  child: StaticBox.text(
                    text: '${trader.location}',
                    color: Colors.blueAccent[400],
                  ))
              : emptyBox,
          const SizedBox(height: 4.0),
          RowItem(
            text: Text(
              trader.active ? 'Leaves on' : 'Arrives on',
              style: title,
            ),
            child: trader.active
                ? DateView(expiry: trader.expiry)
                : DateView(expiry: trader.activation),
          ),
          trader.active
              ? _InventoryButton(inventory: trader.inventory)
              : emptyBox,
        ]));
  }
}

class _InventoryButton extends StatelessWidget {
  const _InventoryButton({Key key, @required this.inventory}) : super(key: key);

  final List<InventoryItem> inventory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Material(
        elevation: 2.0,
        color: Colors.blueAccent[400],
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed('inventory', arguments: inventory),
          child: Container(
              width: 500.0,
              height: 30.0,
              alignment: Alignment.center,
              child: const Text(
                'Baro Ki\'Teeer Inventory',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              )),
        ),
      ),
    );
  }
}
