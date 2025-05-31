import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  Widget _buildAlerts(Alert a, WarframestatRepository r) {
    final reward = a.mission.reward!.items.firstOrNull?.replaceAll('Blueprint', '').trim();

    if (reward == null) return _AlertWidget(alert: a, isParent: false);

    return BlocProvider(create: (_) => ItemCubit(reward, r)..fetchByName(), child: _AlertWidget(alert: a));
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (previous is! WorldstateSuccess || next is! WorldstateSuccess) return false;

    return const DeepCollectionEquality().equals(previous.seed.alerts, next.seed.alerts);
  }

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return BlocBuilder<WorldstateBloc, WorldState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final alerts = switch (state) {
          WorldstateSuccess() => state.seed.alerts,
          _ => <Alert>[],
        };

        return Column(children: alerts.map((a) => _buildAlerts(a, wsRepo)).map((i) => AppCard(child: i)).toList());
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

    final enemyLvlRange = context.l10n.levelInfo(mission.minEnemyLevel ?? 0, mission.maxEnemyLevel ?? 0);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Text(node),
                if (mission.archwingRequired ?? false)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(WarframeIcons.archwing, color: Colors.blue, size: 25),
                  ),
              ],
            ),
            subtitle: Text('$type ($faction) | $enemyLvlRange'),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(alert.expiry), expiry: alert.expiry),
            dense: true,
          ),
          if (isParent) _AlertItemReward(reward: reward) else _AlertReward(reward: reward),
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
      leading: item != null ? CachedNetworkImage(imageUrl: item!.imageUrl, height: 100, width: 60) : null,
      title: RichText(
        text: TextSpan(
          text: reward?.itemString,
          style: context.theme.textTheme.titleMedium,
          children: [
            if (reward?.credits != null)
              TextSpan(
                text: ' + ${credits}cr',
                style: context.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
              ),
          ],
        ),
      ),
      subtitle:
          item?.description != null ? Text(item!.description!, maxLines: 2, overflow: TextOverflow.ellipsis) : null,
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
        final item = switch (state) {
          ItemFetchSuccess() => state.item,
          _ => null,
        };

        if (item == null) return _AlertReward(reward: reward);

        return EntryViewOpenContainer(
          item: item as MinimalItem,
          builder: (_, _) => _AlertReward(reward: reward, item: item),
        );
      },
    );
  }
}
