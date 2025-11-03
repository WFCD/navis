import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/utils/mastery_utils.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItemWidget extends StatelessWidget {
  const ArsenalItemWidget({super.key, required this.item});

  final CodexItem item;

  @override
  Widget build(BuildContext context) {
    final codex = RepositoryProvider.of<Codex>(context);
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    final rank = masteryRank(item, item.xpInfo.value!.xp);

    return OpenContainer(
      openColor: Theme.of(context).colorScheme.surfaceContainer,
      closedColor: Colors.transparent,
      openBuilder: (context, _) {
        return BlocProvider(
          create: (_) => ItemCubit(item.uniqueName, codex, repo)..fetchItem(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<ItemCubit, ItemState>(
                builder: (context, state) {
                  return switch (state) {
                    ItemNotFound() => const Center(child: Text('Item Not Found')),
                    ItemFetchSuccess(item: final item) => EntryView(
                      uniqueName: item.uniqueName,
                      name: item.name,
                      description: item.description,
                      imageUrl: imageUri(item.imageName),
                      type: item.type,
                      wikiaUrl: item.wikiaUrl,
                      wikiaThumbnail: item.wikiaThumbnail,
                    ),
                    _ => const Center(child: WarframeSpinner()),
                  };
                },
              );
            },
          ),
        );
      },
      closedBuilder: (context, onTap) {
        return AppCard(
          color: rank == item.maxLevelCap! ? Theme.of(context).colorScheme.secondaryContainer : null,
          child: ArsenalItemTitle(
            name: item.name,
            imageName: item.imageName!,
            rank: rank,
            maxRank: item.maxLevelCap!,
          ),
        );
      },
    );
  }
}

class ArsenalItemTitle extends StatelessWidget {
  const ArsenalItemTitle({
    super.key,
    required this.name,
    required this.imageName,
    required this.rank,
    required this.maxRank,
  });

  final String name;
  final String imageName;
  final int rank;
  final int maxRank;

  @override
  Widget build(BuildContext context) {
    const leadingSize = 50.0;

    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: imageUri(imageName),
        width: leadingSize,
        errorWidget: (context, url, error) => const Icon(WarframeIcons.menuLotusEmblem, size: leadingSize),
      ),
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
