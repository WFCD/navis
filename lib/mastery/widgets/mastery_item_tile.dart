import 'package:animations/animations.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/items/views/views.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';

class MasteryItemTile extends StatelessWidget {
  const MasteryItemTile({super.key, required this.masterableItem, this.enableCard = true});

  final MasterableItem masterableItem;
  final bool enableCard;

  @override
  Widget build(BuildContext context) {
    final rank = masterableItem.level;
    final maxRank = masterableItem.item.maxLevel ?? 30;

    return OpenContainer(
      openColor: Theme.of(context).colorScheme.surfaceContainer,
      closedColor: enableCard ? Colors.transparent : context.theme.canvasColor,
      openBuilder: (context, _) {
        return ItemDetailPage(item: masterableItem.item);
      },
      closedBuilder: (context, onTap) {
        final content = _MasteryItemTileContent(
          name: masterableItem.item.name,
          imageName: masterableItem.item.imageName ?? '',
          rank: rank,
          maxRank: maxRank,
        );

        if (enableCard) {
          return AppCard(
            color: rank == maxRank ? Theme.of(context).colorScheme.secondaryContainer : null,
            child: content,
          );
        }

        return content;
      },
    );
  }
}

class _MasteryItemTileContent extends StatelessWidget {
  const _MasteryItemTileContent({
    required this.name,
    required this.imageName,
    required this.rank,
    required this.maxRank,
  });

  final String name;
  final String? imageName;
  final int rank;
  final int maxRank;

  @override
  Widget build(BuildContext context) {
    const leadingSize = 50.0;

    return ListTile(
      leading: imageName != null
          ? CachedNetworkImage(
              imageUrl: imageName.warframeItemsCdn().optimize(
                pixelRatio: MediaQuery.devicePixelRatioOf(context),
              ),
              width: leadingSize,
              errorWidget: (context, url, error) => const Icon(WarframeIcons.menuLotusEmblem, size: leadingSize),
            )
          : null,
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rank != 0) Text(context.l10n.itemRankSubtitle(rank)),
          if (rank != maxRank) LinearProgressIndicator(value: rank / maxRank),
        ],
      ),
    );
  }
}
