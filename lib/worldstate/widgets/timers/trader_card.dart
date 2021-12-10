import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/views/trader_inventory.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({Key? key}) : super(key: key);

  Widget _buildButton(BuildContext context, List<InventoryItem> inventory) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(width, 36)),
      onPressed: () => Navigator.of(context)
          .pushNamed(BaroInventory.route, arguments: inventory),
      child: Text(
        context.l10n.baroInventory,
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 4, vertical: 4);

    return BlocBuilder<SolsystemCubit, SolsystemState>(
      builder: (context, state) {
        final trader = (state as SolState).worldstate.voidTrader;
        final l10n = context.l10n;

        final date = trader.active ? trader.expiry! : trader.activation!;

        return AppCard(
          title: l10n.baroTitle,
          child: Column(
            children: <Widget>[
              RowItem(
                text:
                    Text(trader.active ? l10n.baroLeaving : l10n.baroArriving),
                padding: padding,
                child: CountdownTimer(
                  tooltip: l10n.countdownTooltip(date),
                  expiry: date,
                ),
              ),
              if (trader.active)
                RowItem(
                  text: Text(l10n.baroLocation),
                  padding: padding,
                  child: ColoredContainer.text(
                    text: trader.location,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              RowItem(
                text: Text(
                  trader.active ? l10n.baroLeavesOn : l10n.baroArrivesOn,
                ),
                padding: padding,
                child: ColoredContainer.text(
                  color: Theme.of(context).colorScheme.primary,
                  text: MaterialLocalizations.of(context).formatFullDate(date),
                ),
              ),
              SizedBoxSpacer.spacerHeight2,
              if (trader.active) _buildButton(context, trader.inventory)
            ],
          ),
        );
      },
    );
  }
}
