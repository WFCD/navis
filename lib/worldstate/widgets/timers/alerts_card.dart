import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        builder: (context, state) {
          final alerts = switch (state) {
            WorldstateSuccess() => state.worldstate.alerts,
            _ => <Alert>[],
          };

          return Column(
            children: alerts.map((a) => _AlertWidget(alert: a)).toList(),
          );
        },
      ),
    );
  }
}

class _AlertWidget extends StatelessWidget {
  const _AlertWidget({required this.alert});

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
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem(
            icons: <Widget>[
              // Since nightmare alerts aren't visible in the worldstate there
              // is no need for a nightmare icon for alerts.
              if (mission.archwingRequired ?? false)
                const Icon(
                  WarframeSymbols.archwing,
                  color: Colors.blue,
                  size: 25,
                ),
            ],
            text: Text(node),
            child:
                ColoredContainer.text(text: mission.reward?.itemString ?? ''),
          ),
          RowItem(
            text: Text(
              '$type ($faction) | $enemyLvlRange',
              style: textTheme.bodySmall,
            ),
            child: CountdownTimer(
              // Will default to DateTime.now() under the hood.
              // ignore: avoid-non-null-assertion
              tooltip: context.l10n.countdownTooltip(alert.expiry),
              // Will default to DateTime.now() under the hood.
              // ignore: avoid-non-null-assertion
              expiry: alert.expiry,
            ),
          ),
        ],
      ),
    );
  }
}
