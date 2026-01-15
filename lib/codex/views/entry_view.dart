import 'package:animations/animations.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

const List<ItemType> _miscTypes = [ItemType.skin, ItemType.misc, ItemType.glyph];

class EntryViewOpenContainer extends StatelessWidget {
  const EntryViewOpenContainer({
    super.key,
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.type,
    this.imageName,
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
  final String? imageName;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  final Color? openColor;
  final Color? closedColor;
  final Widget Function(BuildContext, void Function()) builder;

  @override
  Widget build(BuildContext context) {
    if (_miscTypes.contains(type)) {
      return builder(context, () {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: MinimalItemOverview(
                name: name,
                description: description,
                imageName: imageName,
              ),
            );
          },
        );
      });
    }

    return OpenContainer(
      closedElevation: 0,
      useRootNavigator: context.rootNavigator.mounted,
      openColor: openColor ?? Theme.of(context).colorScheme.surfaceContainer,
      closedColor: closedColor ?? Colors.transparent,
      openBuilder: (_, _) => EntryView(
        uniqueName: uniqueName,
        name: name,
        description: description,
        imageName: imageName,
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
    required this.type,
    this.imageName,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
  });

  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  @override
  Widget build(BuildContext context) {
    final codex = RepositoryProvider.of<Codex>(context);
    final repo = RepositoryProvider.of<WarframestatRepository>(context);
    final overview = _Overview(
      uniqueName: uniqueName,
      name: name,
      description: description,
      imageName: imageName,
      type: type,
      vaulted: vaulted,
      wikiaUrl: wikiaUrl,
      wikiaThumbnail: wikiaThumbnail,
    );

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ItemCubit(uniqueName, codex, repo)..fetchItem(),
          child: overview,
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.type,
    this.imageName,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
  });

  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
  final ItemType type;
  final bool? vaulted;
  final String? wikiaUrl;
  final String? wikiaThumbnail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          final item = switch (state) {
            ItemFetchSuccess() => state.item,
            _ => null,
          };

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

          final heightRatio = context.mediaQuery.size.height / 100;
          final height = isMod ? kToolbarHeight : heightRatio * 30;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ItemOverviewAppBar(
                  imageName: imageName,
                  name: name,
                  description: description,
                  releaseDate: item?.releaseDate,
                  isMod: isMod,
                  isVaulted: vaulted ?? false,
                  wikiUrl: wikiaUrl,
                  expandedHeight: height,
                ),
              ),
              if (state is ItemFetchFailure)
                SliverToBoxAdapter(
                  child: Center(child: Text(context.l10n.itemFailureErrorText)),
                ),
              if (state is! ItemFetchSuccess)
                const SliverFillRemaining(hasScrollBody: false, child: Center(child: WarframeSpinner()))
              else
                SliverList.list(
                  children: [
                    if (isFoundryItem)
                      ItemComponents(
                        itemImageName: imageName,
                        components: (item! as BuildableItem).components!,
                      ),
                    if (isPowerSuit) FrameStats(powerSuit: item),
                    if (isGun) GunStats(gun: item),
                    if (isMelee) MeleeStats(melee: item),
                    if (isMod) ModStats(mod: item),
                    if (isRelic) RelicRewardWidget(relic: item),
                    if (drops != null) DropLocations(drops: drops),
                    if (item!.patchlogs != null) PatchlogSection(patchlogs: item.patchlogs!),
                  ].map((child) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: child)).toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}
