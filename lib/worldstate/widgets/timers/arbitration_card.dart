import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        builder: (context, state) {
          final arbitration =
              state is SolState ? state.worldstate.arbitration! : null;
          final expiry = arbitration?.expiry ?? DateTime.now().add(kDelayLong);

          return ListTile(
            leading: const AppIcon(GenesisAssets.arbitrations, size: 40),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (arbitration?.archwingRequired ?? false)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      GenesisAssets.archwing,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ),
                Text(arbitration?.node ?? ''),
              ],
            ),
            subtitle: Text('${arbitration?.enemy} | ${arbitration?.type}'),
            trailing: CountdownTimer(
              tooltip: context.l10n.countdownTooltip(expiry),
              expiry: expiry,
            ),
          );
        },
      ),
    );
  }
}
