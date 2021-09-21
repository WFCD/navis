import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/icons.dart';
import '../../../../../core/widgets/row_item.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../bloc/solsystem_bloc.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
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
  const AlertWidget({Key? key, required this.alert}) : super(key: key);

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
              // Not sure we need to add nightmare
              // icon since alerts have be axed and
              // nightmare alerts aren't visible to us.
              if (alert.archwingRequired ?? false)
                NavisSystemIconWidgets.archwingIcon
            ],
            text: Text(node),
            child: StaticBox.text(text: mission.reward?.itemString ?? ''),
          ),
          RowItem(
            text: Text(
              '$type ($faction) | $enemyLvlRange',
              style: textTheme.caption,
            ),
            child: CountdownTimer(expiry: alert.expiry!),
          )
        ],
      ),
    );
  }
}
