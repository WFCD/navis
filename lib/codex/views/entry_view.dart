import 'package:animations/animations.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class EntryViewOpenContainer extends StatelessWidget {
  const EntryViewOpenContainer({
    super.key,
    this.openColor,
    this.closedColor,
    required this.item,
    required this.builder,
  });

  final Color? openColor;
  final Color? closedColor;
  final MinimalItem item;
  final Widget Function(BuildContext, void Function()) builder;

  @override
  Widget build(BuildContext context) {
    const elevation = 0.0;

    if (item.type == ItemType.misc) {
      return InkWell(
        child: builder(context, () {}),
        onTap: () {
          showBottomSheet(
            context: context,
            builder:
                (context) => EntryContent(
                  uniqueName: item.uniqueName,
                  name: item.name,
                  description: item.description ?? '',
                  imageUrl: item.imageUrl,
                ),
          );
        },
      );
    }

    return OpenContainer(
      closedElevation: elevation,
      useRootNavigator: context.rootNavigator.mounted,
      openColor: openColor ?? Theme.of(context).colorScheme.surfaceContainer,
      closedColor: closedColor ?? Colors.transparent,
      openBuilder: (_, __) => EntryView(item: item),
      closedBuilder: builder,
    );
  }
}

class EntryView extends StatelessWidget {
  const EntryView({super.key, required this.item});

  final MinimalItem item;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    return BlocProvider(
      create: (context) => ItemCubit(item.uniqueName, repo)..fetchItem(),
      child: Scaffold(body: SafeArea(child: _Overview(item: item))),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.item});

  final MinimalItem item;

  @override
  Widget build(BuildContext context) {
    final isMod = item.type.name.contains('Mod');
    final patchlogs = item.patchlogs;
    final heightRatio = context.mediaQuery.size.height / 100;
    final height = isMod ? kToolbarHeight : heightRatio * 25;

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              if (isMod)
                SliverAppBar(title: Text(item.name))
              else
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BasicItemInfo(
                    uniqueName: item.uniqueName,
                    name: item.name,
                    description: item.description?.parseHtmlString() ?? '',
                    wikiaUrl: item.wikiaUrl,
                    imageUrl: item.imageUrl,
                    expandedHeight: height,
                    disableInfo: isMod,
                    isVaulted: item.vaulted,
                  ),
                ),
            ];
          },
          body: BlocBuilder<ItemCubit, ItemState>(
            builder: (context, state) {
              if (state is ItemFetchFailure) {
                return Center(child: Text(state.message));
              }

              if (state is! ItemFetchSuccess) {
                return const Center(child: WarframeSpinner());
              }

              final item = state.item;
              final isPowerSuit = item is PowerSuit;
              final isGun = item is Gun;
              final isMelee = item is Melee;
              final isMod = item is Mod;
              final isRelic = item is Relic;

              var isFoundryItem = item is BuildableItem;
              if (isFoundryItem) {
                final components = item.components;
                isFoundryItem = components != null && components.isNotEmpty;
              }

              List<Drop>? drops;
              if (item is DroppableItem) {
                drops = item.drops;
              }

              return ListView(
                children:
                    [
                          if (isFoundryItem)
                            ItemComponents(
                              itemImageUrl: item.imageUrl,
                              components: (item as BuildableItem).components!,
                            ),
                          if (isPowerSuit) FrameStats(powerSuit: item),
                          if (isGun) GunStats(gun: item),
                          if (isMelee) MeleeStats(melee: item),
                          if (isMod) ModStats(mod: item),
                          if (isRelic) RelicRewardWidget(relic: item),
                          if (drops != null) DropLocations(drops: drops),
                          if (patchlogs != null) PatchlogSection(patchlogs: patchlogs),
                        ]
                        .map((w) => Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10), child: w))
                        .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
