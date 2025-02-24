import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        builder: (context, state) {
          final arbitration = switch (state) {
            WorldstateSuccess() => state.worldstate.arbitration,
            _ => null,
          };

          final now = DateTime.timestamp();
          var expiry = arbitration?.expiry ?? DateTime.now().add(expiryWait);

          if (expiry.difference(now) > const Duration(days: 365)) {
            expiry = DateTime.now().add(expiryWait);
          }

          return ListTile(
            leading: const AppIcon(WarframeSymbols.arbitrations, size: 50),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (arbitration?.archwing ?? false)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(WarframeSymbols.archwing, color: Colors.blue, size: 25),
                  ),
                Text(arbitration?.node ?? ''),
              ],
            ),
            subtitle: Text('${arbitration?.enemy} | ${arbitration?.type}'),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
