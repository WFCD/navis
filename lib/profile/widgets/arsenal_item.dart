import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/views/entry_view.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItemWidget extends StatelessWidget {
  const ArsenalItemWidget({super.key, required this.progress});

  final MasteryProgress progress;

  @override
  Widget build(BuildContext context) {
    const leadingSize = 50.0;

    return EntryViewOpenContainer(
      item: progress.item,
      builder: (context, onTap) {
        return AppCard(
          color: progress.rank == progress.maxRank
              ? Theme.of(context).colorScheme.secondaryContainer
              : null,
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: progress.item.imageUrl,
              width: leadingSize,
              errorWidget: (context, url, error) => const Icon(
                WarframeSymbols.menu_LotusEmblem,
                size: leadingSize,
              ),
            ),
            title: Text(progress.item.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (progress.rank != 0)
                  Text(context.l10n.itemRankSubtitle(progress.rank)),
                if (progress.rank != progress.maxRank && progress.rank != 0)
                  LinearProgressIndicator(
                    value: progress.rank / progress.maxRank,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
