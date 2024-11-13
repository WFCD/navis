import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return BlocBuilder<WorldstateCubit, SolsystemState>(
      builder: (context, state) {
        final alerts = switch (state) {
          WorldstateSuccess() => state.worldstate.alerts,
          _ => <Alert>[],
        };

        return Column(
          children: alerts.map((a) {
            return AppCard(
              child: BlocProvider(
                create: (_) => ItemCubit(
                  a.mission.reward!.countedItems[0].type,
                  wsRepo,
                )..fetchByName(),
                child: _AlertWidget(alert: a),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _AlertWidget extends StatelessWidget {
  const _AlertWidget({required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final mission = alert.mission;

    final node = mission.node;
    final type = mission.type;
    final faction = mission.faction;
    final reward = mission.reward;

    final enemyLvlRange = context.l10n
        .levelInfo(mission.minEnemyLevel ?? 0, mission.maxEnemyLevel ?? 0);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Text(node),
                if (mission.archwingRequired ?? false) ...{
                  SizedBoxSpacer.spacerWidth8,
                  const Icon(
                    WarframeSymbols.archwing,
                    color: Colors.blue,
                    size: 25,
                  ),
                },
              ],
            ),
            subtitle: Text('$type ($faction) | $enemyLvlRange'),
            trailing: CountdownTimer(
              tooltip: context.l10n.countdownTooltip(alert.expiry),
              expiry: alert.expiry,
            ),
            dense: true,
          ),
          _AlertReward(reward: reward),
        ],
      ),
    );
  }
}

class _AlertReward extends StatelessWidget {
  const _AlertReward({required this.reward});

  final Reward? reward;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final item =
            switch (state) { ItemFetchSuccess() => state.item, _ => null };

        final credits = NumberFormat().format(reward?.credits ?? 0);

        final child = ListTile(
          title: RichText(
            text: TextSpan(
              text: reward?.itemString,
              children: [
                if (reward?.credits != null)
                  TextSpan(
                    text: ' + $credits credits',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          subtitle: item?.description != null
              ? Text(
                  item!.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: item != null
              ? CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  height: 100,
                  width: 60,
                )
              : null,
          isThreeLine: item != null,
          dense: true,
        );

        if (item == null) return child;

        return EntryViewOpenContainer(
          item: item as MinimalItem,
          builder: (_, __) => child,
        );
      },
    );
  }
}
