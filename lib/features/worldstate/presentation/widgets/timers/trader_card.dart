import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../pages/trader_inventory.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({Key? key, required this.trader}) : super(key: key);

  final VoidTrader trader;

  Widget _buildButton(BuildContext context, List<InventoryItem> inventory) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(width, 36)),
      onPressed: () => Navigator.of(context)
          .pushNamed(BaroInventory.route, arguments: inventory),
      child: Text(
        context.l10n.baroInventory,
        style: const TextStyle(fontSize: 17.0, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0);
    final l10n = context.l10n;

    final formattedDate = trader.active
        ? trader.expiry!.format(context)
        : trader.activation!.format(context);

    return CustomCard(
      title: l10n.baroTitle,
      child: Column(children: <Widget>[
        RowItem(
          text: Text(trader.active ? l10n.baroArriving : l10n.baroLeaving),
          padding: padding,
          child: CountdownTimer(
            expiry: trader.active ? trader.expiry! : trader.activation!,
          ),
        ),
        if (trader.active)
          RowItem(
            text: Text(l10n.baroLocation),
            padding: padding,
            child: StaticBox.text(
              text: '${trader.location}',
              color: primary,
            ),
          ),
        RowItem(
          text: Text(
            trader.active ? l10n.baroLeavesOn : l10n.baroArrivesOn,
          ),
          padding: padding,
          child: StaticBox.text(
            color: primary,
            text: formattedDate,
          ),
        ),
        const SizedBox(height: 2.0),
        if (trader.active) _buildButton(context, trader.inventory)
      ]),
    );
  }
}
