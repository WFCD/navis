import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        builder: (context, state) {
          final alerts = (state as SolState).worldstate.alerts;

          return Column(
            children: alerts.map((a) => AlertWidget(alert: a)).toList(),
          );
        },
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key, required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mission = alert.mission;

    final node = mission.node;
    final type = mission.type;
    final faction = mission.faction;
    final enemyLvlRange = context.l10n
        .levelInfo(mission.minEnemyLevel ?? 0, mission.maxEnemyLevel ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem(
            icons: <Widget>[
              // Since nightmare alerts aren't visible in the worldstate there
              // is no need for a nightmare icon for alerts.
              if (alert.archwingRequired ?? false)
                const Icon(GenesisAssets.archwing, color: Colors.blue, size: 25)
            ],
            text: Text(node),
            child:
                ColoredContainer.text(text: mission.reward?.itemString ?? ''),
          ),
          RowItem(
            text: Text(
              '$type ($faction) | $enemyLvlRange',
              style: textTheme.caption,
            ),
            child: CountdownTimer(
              tooltip: context.l10n.countdownTooltip(alert.expiry!),
              expiry: alert.expiry!,
            ),
          )
        ],
      ),
    );
  }
}
