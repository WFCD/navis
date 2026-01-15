import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:codex/codex.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart' show ItemCommon;
import 'package:warframestat_repository/warframestat_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  Widget _buildAlerts(Alert a, Codex c, WarframestatRepository r) {
    final reward = a.mission.reward.items?.firstOrNull?.replaceAll('Blueprint', '').trim();

    if (reward == null) return _AlertWidget(alert: a, isParent: false);

    return BlocProvider(
      create: (_) => ItemCubit(reward, c, r)..fetchByName(),
      child: _AlertWidget(alert: a),
    );
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (previous is! WorldstateSuccess || next is! WorldstateSuccess) return false;

    return const DeepCollectionEquality().equals(previous.seed.alerts, next.seed.alerts);
  }

  @override
  Widget build(BuildContext context) {
    final codex = RepositoryProvider.of<Codex>(context);
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return BlocBuilder<WorldstateBloc, WorldState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final alerts = switch (state) {
          WorldstateSuccess() => state.seed.alerts,
          _ => <Alert>[],
        };

        return Column(
          children: alerts.map((a) => _buildAlerts(a, codex, wsRepo)).map((i) => AppCard(child: i)).toList(),
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

    final enemyLvlRange = context.l10n.levelInfo(mission.minEnemyLevel, mission.maxEnemyLevel);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Text(node),
                if (mission.archwingRequired)
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

  final Reward reward;
  final ItemCommon? item;

  @override
  Widget build(BuildContext context) {
    final rewardItem = reward.countedItems?.first;

    return ListTile(
      leading: item != null
          ? CircleAvatar(
              radius: 25,
              foregroundImage: CachedNetworkImageProvider(
                item!.imageName.warframeItemsCdn().optimize(pixelRatio: MediaQuery.devicePixelRatioOf(context)),
              ),
            )
          : null,
      title: RichText(
        text: TextSpan(
          text: rewardItem != null ? '${rewardItem.count}x ${rewardItem.type}' : reward.items?.first ?? '',
          style: context.theme.textTheme.titleMedium,
          children: [
            if (reward.credits != null)
              TextSpan(
                text: ' + ${NumberFormat().format(reward.credits ?? 0)}cr',
                style: context.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
              ),
          ],
        ),
      ),
      subtitle: item?.description != null
          ? Text(item!.description!, maxLines: 3, overflow: TextOverflow.ellipsis)
          : null,
      isThreeLine: item != null,
      dense: true,
    );
  }
}

class _AlertItemReward extends StatelessWidget {
  const _AlertItemReward({required this.reward});

  final Reward reward;

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
          uniqueName: item.uniqueName,
          name: item.name,
          description: item.description,
          imageName: item.imageName,
          type: item.type,
          wikiaUrl: item.wikiaUrl,
          wikiaThumbnail: item.wikiaThumbnail,
          builder: (_, onTap) => InkWell(
            onTap: onTap,
            child: _AlertReward(reward: reward, item: item),
          ),
        );
      },
    );
  }
}
