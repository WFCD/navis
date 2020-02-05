import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/l10n/localizations.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class TraderPanel extends StatelessWidget {
  const TraderPanel({Key key, @required this.trader}) : super(key: key);

  final VoidTrader trader;

  @override
  Widget build(BuildContext context) {
    final navisLocale = NavisLocalizations.of(context);
    final materialLocale = MaterialLocalizations.of(context);

    final formattedDate = materialLocale
        .formatFullDate(trader.active ? trader.expiry : trader.activation);

    return Panel(
      title: 'Void Trader',
      child: Column(children: <Widget>[
        ListTile(
          title: Text(trader.active
              ? navisLocale.baroArriving
              : navisLocale.baroLeaving),
          trailing: CountdownTimer(
            expiry: trader.active ? trader.expiry : trader.activation,
          ),
        ),
        if (trader.active)
          ListTile(
            title: const Text('Loaction'),
            trailing: StaticBox.text(
              text: '${trader.location}',
              color: Theme.of(context).primaryColor,
            ),
          ),
        ListTile(
          title: Text(
            trader.active
                ? navisLocale.baroLeavesOn
                : navisLocale.baroArrivesOn,
          ),
          trailing: StaticBox.text(
            color: Theme.of(context).primaryColor,
            text: formattedDate,
          ),
        ),
        const SizedBox(height: 2.0),
        if (trader.active)
          ButtonBar(children: <Widget>[
            OutlineButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('inventory', arguments: trader.inventory);
              },
              // borderSide: BorderSide(color: Theme.of(context).primaryColor),
              // textColor: Theme.of(context).primaryColor,
              child: Text(navisLocale.baroInventory),
            )
          ])
      ]),
    );
  }
}
