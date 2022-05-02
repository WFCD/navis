import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/views/trader_inventory.dart';
import 'package:navis_ui/navis_ui.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      builder: (context, state) {
        final trader = (state as SolState).worldstate.voidTrader;
        final l10n = context.l10n;

        final date = MaterialLocalizations.of(context).formatFullDate(
          trader.active ? trader.expiry! : trader.activation!,
        );
        final status = trader.active ? l10n.baroLeavesOn : l10n.baroArrivesOn;

        return InkWell(
          onTap: trader.active
              ? () => Navigator.of(context)
                  .pushNamed(BaroInventory.route, arguments: trader.inventory)
              : null,
          child: AppCard(
            padding: EdgeInsets.zero,
            color: const Color(0xFF82598b),
            child: SizedBox(
              height: 150,
              child: ImageContainer(
                imageProvider: const AssetImage(
                  'assets/baro_banner.webp',
                  package: 'navis_ui',
                ),
                height: 150,
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(l10n.baroTitle),
                  subtitle: Text(
                    trader.active
                        ? 'Tap for Inventory\n$status $date'
                        : '$status $date',
                  ),
                  trailing: CountdownTimer(
                    tooltip: l10n.countdownTooltip(date),
                    color: const Color(0xFF82598b),
                    expiry: trader.active ? trader.expiry! : trader.activation!,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
