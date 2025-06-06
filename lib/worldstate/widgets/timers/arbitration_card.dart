import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    const gracePeriod = Duration(seconds: 1);
    const oneYear = Duration(days: 365);

    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        builder: (context, state) {
          final arbitration = switch (state) {
            WorldstateSuccess() => state.seed.arbitration,
            _ => null,
          };

          final now = DateTime.timestamp();

          var expiry = arbitration?.expiry ?? now.add(gracePeriod);
          if (expiry.difference(now) > oneYear) {
            expiry = now.add(gracePeriod);
          }

          return ListTile(
            leading: const AppIcon(WarframeIcons.arbitrations, size: 50),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (arbitration?.archwing ?? false)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(WarframeIcons.archwing, color: Colors.blue, size: 25),
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
