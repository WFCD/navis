import 'package:flutter/material.dart';
import 'package:navis/core/themes/colors.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/pages/trader_inventory.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:warframestat_api_models/entities.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({Key key, @required this.trader}) : super(key: key);

  final VoidTrader trader;

  Widget _buildButton(BuildContext context, List<InventoryItem> inventory) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(width, 36)),
      onPressed: () => Navigator.of(context)
          .pushNamed(BaroInventory.route, arguments: inventory),
      child: Text(
        context.locale.baroInventory,
        style: const TextStyle(fontSize: 17.0, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0);
    final materialLocale = MaterialLocalizations.of(context);

    final formattedDate = materialLocale
        .formatFullDate(trader.active ? trader.expiry : trader.activation);

    return CustomCard(
      title: context.locale.baroTitle,
      child: Column(children: <Widget>[
        RowItem(
          text: Text(trader.active
              ? context.locale.baroArriving
              : context.locale.baroLeaving),
          padding: padding,
          child: CountdownTimer(
            expiry: trader.active ? trader.expiry : trader.activation,
          ),
        ),
        if (trader.active)
          RowItem(
            text: Text(context.locale.baroLocation),
            padding: padding,
            child: StaticBox.text(
              text: '${trader.location}',
              color: primary,
            ),
          ),
        RowItem(
          text: Text(
            trader.active
                ? context.locale.baroLeavesOn
                : context.locale.baroArrivesOn,
          ),
          padding: padding,
          child: StaticBox.text(
            color: primary,
            text: formattedDate,
          ),
        ),
        const SizedBox(height: 2.0),
        _buildButton(context, trader.inventory)
      ]),
    );
  }
}
