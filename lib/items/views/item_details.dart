import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/cubit/item_cubit.dart';
import 'package:navis/items/widgets/widgets.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' hide ItemNotFound;

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.item});

  final WarframeItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ItemCubit(context.read<ItemsRepository>())..fetchItemApi(item.uniqueName),
        child: ItemDetailView(item: item),
      ),
    );
  }
}

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key, required this.item});

  final WarframeItem item;

  Widget? _stats(BuildContext context, ItemCommon item) {
    return switch (item) {
      PowerSuit() => AvatarStats(avatar: item),
      Gun() => GunStats(gun: item),
      Melee() => MeleeStats(melee: item),
      Mod() => ModStats(mod: item),
      Arcane() => ArcaneStats(arcane: item),
      Relic() => RelicRewardWidget(relic: item),
      _ => null,
    };
  }

  double _calculateHeight(BuildContext context) {
    final heightRatio = context.mediaQuery.size.height / 100;
    return heightRatio * 30;
  }

  Widget _fillRemaining(Widget child) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          final item = switch (state) {
            ItemApiFetchSuccess(:final item) => item,
            _ => null,
          };

          final patchlogs = item?.patchlogs;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ItemHeaderAppBar(item: this.item, expandedHeight: _calculateHeight(context)),
              ),
              if (state is ItemFetchInProgress) _fillRemaining(const WarframeSpinner()),
              if (state case ItemFetchFailure() || ItemNotFound())
                _fillRemaining(Text(context.l10n.itemFailureErrorText)),
              SliverPadding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                sliver: SliverList.list(
                  children: [
                    if (item case BuildableItem(:final components) when components != null) ItemComponents(item: item),
                    if (state case ItemApiFetchSuccess(:final item)) ?_stats(context, item),
                    if (item case DroppableItem(:final drops) when drops != null) DropLocations(drops: drops),
                    if (patchlogs != null) PatchlogSection(patchlogs: patchlogs),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
