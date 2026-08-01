import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/items.dart';

import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key});

  Widget _buildAlert(Alert alert) {
    final reward = alert.mission.reward.items?.firstOrNull;
    if (reward == null) return _AlertWidget(alert: alert, isParent: false);

    return BlocProvider(
      create: (context) => ItemCubit(context.read<ItemsRepository>())..fetchByName(reward),
      child: _AlertWidget(alert: alert),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, List<Alert>>(
      selector: (state) => switch (state) {
        WorldstateSuccess(:final seed) => seed.alerts,
        _ => <Alert>[],
      },
      builder: (context, alerts) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: alerts.map(_buildAlert).toList(),
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

    return AppCard(
      child: Padding(
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
      ),
    );
  }
}

class _AlertReward extends StatelessWidget {
  const _AlertReward({required this.reward, this.item});

  final Reward reward;
  final WarframeItem? item;

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
    final item = switch (context.watch<ItemCubit>().state) {
      ItemStoreFetchSuccess(:final item) => item,
      _ => null,
    };

    if (item == null) return _AlertReward(reward: reward);

    return OpenItemContainer(
      item: item,
      closedBuilder: (context, action) => _AlertReward(reward: reward, item: item),
    );
  }
}
