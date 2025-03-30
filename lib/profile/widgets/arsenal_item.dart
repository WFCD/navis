import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/utils/extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItemWidget extends StatelessWidget {
  const ArsenalItemWidget({super.key, required this.item});

  final InventoryItemData item;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    return OpenContainer(
      openColor: Theme.of(context).colorScheme.surfaceContainer,
      closedColor: Colors.transparent,
      openBuilder: (context, _) {
        return BlocProvider(
          create: (_) => ItemCubit(item.uniqueName, repo)..fetchItem(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<ItemCubit, ItemState>(
                builder: (context, state) {
                  return switch (state) {
                    ItemNotFound() => const Center(child: Text('Item Not Found')),
                    ItemFetchSuccess(item: final item) => EntryView(item: item),
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
          color: item.rank == item.maxRank ? Theme.of(context).colorScheme.secondaryContainer : null,
          child: ArsenalItemTitle(item: item),
        );
      },
    );
  }
}

class ArsenalItemTitle extends StatelessWidget {
  const ArsenalItemTitle({super.key, required this.item});

  final InventoryItemData item;

  @override
  Widget build(BuildContext context) {
    const leadingSize = 50.0;

    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: imageUri(item.image),
        width: leadingSize,
        errorWidget: (context, url, error) => const Icon(WarframeSymbols.menu_LotusEmblem, size: leadingSize),
      ),
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.rank != 0) Text(context.l10n.itemRankSubtitle(item.rank)),
          if (item.rank != item.maxRank && item.rank != 0) LinearProgressIndicator(value: item.rank / item.maxRank),
        ],
      ),
    );
  }
}
