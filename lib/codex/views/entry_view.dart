import 'package:animations/animations.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class EntryViewOpenContainer extends StatelessWidget {
  const EntryViewOpenContainer({
    super.key,
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
    this.openColor,
    this.closedColor,
    required this.builder,
  });

  final String uniqueName;
  final String name;
  final String? description;
  final String imageUrl;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  final Color? openColor;
  final Color? closedColor;
  final Widget Function(BuildContext, void Function()) builder;

  @override
  Widget build(BuildContext context) {
    const elevation = 0.0;

    if (type == ItemType.misc) {
      return InkWell(
        child: builder(context, () {}),
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (context) => EntryContent(
              uniqueName: uniqueName,
              name: name,
              description: description ?? '',
              imageUrl: imageUrl,
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
      openBuilder: (_, _) => EntryView(
        uniqueName: uniqueName,
        name: name,
        description: description,
        imageUrl: imageUrl,
        type: type,
        vaulted: vaulted,
        wikiaUrl: wikiaUrl,
        wikiaThumbnail: wikiaThumbnail,
      ),
      closedBuilder: builder,
    );
  }
}

class EntryView extends StatelessWidget {
  const EntryView({
    super.key,
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
  });

  final String uniqueName;
  final String name;
  final String? description;
  final String imageUrl;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  static final List<ItemType> _miscTypes = [ItemType.skin, ItemType.misc];

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);
    final overview = _Overview(
      uniqueName: uniqueName,
      name: name,
      description: description,
      imageUrl: imageUrl,
      type: type,
      vaulted: vaulted,
      wikiaUrl: wikiaUrl,
      wikiaThumbnail: wikiaThumbnail,
    );

    return Scaffold(
      body: SafeArea(
        child: !_miscTypes.contains(type)
            ? BlocProvider(
                create: (context) => ItemCubit(uniqueName, repo)..fetchItem(),
                child: overview,
              )
            : overview,
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
  });

  final String uniqueName;
  final String name;
  final String? description;
  final String imageUrl;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  @override
  Widget build(BuildContext context) {
    final isMod = type.name.contains('Mod');
    final heightRatio = context.mediaQuery.size.height / 100;
    final height = isMod ? kToolbarHeight : heightRatio * 25;

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              if (isMod)
                SliverAppBar(title: Text(name))
              else
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BasicItemInfo(
                    uniqueName: uniqueName,
                    name: name,
                    description: description?.parseHtmlString() ?? '',
                    wikiUrl: wikiaUrl,
                    imageUrl: wikiaThumbnail ?? imageUrl,
                    expandedHeight: height,
                    disableInfo: isMod,
                    isVaulted: vaulted,
                  ),
                ),
            ];
          },
          body: BlocBuilder<ItemCubit, ItemState>(
            builder: (context, state) {
              if (state is ItemFetchFailure) {
                return Center(child: Text(context.l10n.itemFailureErrorText));
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
              if (item is DroppableItem) drops = item.drops;

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
                          if (item.patchlogs != null) PatchlogSection(patchlogs: item.patchlogs!),
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
