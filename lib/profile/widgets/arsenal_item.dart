import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItemWidget extends StatelessWidget {
  const ArsenalItemWidget({super.key, required this.item});

  final MasteryProgress item;

  @override
  Widget build(BuildContext context) {
    const leadingSize = 50.0;

    return AppCard(
      color: item.rank == item.maxRank
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: item.item.imageUrl,
          width: leadingSize,
          errorWidget: (context, url, error) => const Icon(
            WarframeSymbols.menu_LotusEmblem,
            size: leadingSize,
          ),
        ),
        title: Text(item.item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.rank != 0) Text(context.l10n.itemRankSubtitle(item.rank)),
            if (item.rank != item.maxRank && item.rank != 0)
              LinearProgressIndicator(value: item.rank / item.maxRank),
          ],
        ),
      ),
    );
  }
}
