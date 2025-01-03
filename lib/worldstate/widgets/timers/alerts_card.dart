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

  Widget _buildAlert(Alert a, WarframestatRepository r) {
    final reward =
        a.mission.reward!.items.firstOrNull?.replaceAll('Blueprint', '').trim();

    if (reward == null) return _AlertWidget(alert: a, isParent: false);

    return BlocProvider(
      create: (_) => ItemCubit(reward, r)..fetchByName(),
      child: _AlertWidget(alert: a),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return BlocSelector<WorldstateCubit, SolsystemState, List<Alert>>(
      selector: (s) => switch (s) {
        WorldstateSuccess() => s.worldstate.alerts,
        _ => <Alert>[],
      },
      builder: (context, alerts) {
        return Column(
          children: alerts
              .map((a) => _buildAlert(a, wsRepo))
              .map((i) => AppCard(child: i))
              .toList(),
        );
      },
    );
  }
}

class _AlertWidget extends StatelessWidget {
  const _AlertWidget({required this.alert, this.isParent = true});

  final Alert alert;
  final bool isParent;

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
                  Gaps.gap8,
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
          if (isParent)
            _AlertItemReward(reward: reward)
          else
            _AlertReward(reward: reward),
        ],
      ),
    );
  }
}

class _AlertReward extends StatelessWidget {
  const _AlertReward({required this.reward, this.item});

  final Reward? reward;
  final Item? item;

  @override
  Widget build(BuildContext context) {
    final credits = NumberFormat().format(reward?.credits ?? 0);

    return ListTile(
      leading: item != null
          ? CachedNetworkImage(
              imageUrl: item!.imageUrl,
              height: 100,
              width: 60,
            )
          : null,
      title: RichText(
        text: TextSpan(
          text: reward?.itemString,
          style: context.theme.textTheme.titleMedium,
          children: [
            if (reward?.credits != null)
              TextSpan(
                text: ' + ${credits}cr',
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
      isThreeLine: item != null,
      dense: true,
    );
  }
}

class _AlertItemReward extends StatelessWidget {
  const _AlertItemReward({required this.reward});

  final Reward? reward;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final item =
            switch (state) { ItemFetchSuccess() => state.item, _ => null };

        if (item == null) return _AlertReward(reward: reward);

        return EntryViewOpenContainer(
          item: item as MinimalItem,
          builder: (_, __) => _AlertReward(reward: reward, item: item),
        );
      },
    );
  }
}
