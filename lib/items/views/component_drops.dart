import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/cubit/item_cubit.dart';
import 'package:navis/items/views/views.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' hide ItemNotFound;

class ComponentDrops extends StatelessWidget {
  ComponentDrops({super.key, required this.controller, required List<Drop> drops})
    : drops = drops.filter().toList()..sortDrops(reverse: true);

  final ScrollController controller;
  final List<Drop> drops;

  void _loadRelic(BuildContext context, String name) {
    final repo = context.read<ItemsRepository>();

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return BlocProvider(
            create: (context) => ItemCubit(repo)..fetchByName(name),
            child: const _RelicView(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollCacheExtent: const ScrollCacheExtent.pixels(500),
      controller: controller,
      itemCount: drops.length,
      itemBuilder: (context, index) {
        final drop = drops[index];
        final percentage = ((drop.chance ?? 0) * 100).toStringAsFixed(2);

        return ListTile(
          title: Text(drop.location),
          subtitle: Text('$percentage%'),
          onTap: drop.uniqueName != null ? () => _loadRelic(context, drop.uniqueName!) : null,
        );
      },
    );
  }
}

class _RelicView extends StatelessWidget {
  const _RelicView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          final l10n = context.l10n;

          return switch (state) {
            ItemFetchInProgress() => const Center(child: WarframeSpinner()),
            ItemNotFound() => Center(child: Text(l10n.codexNoResults)),
            ItemStoreFetchSuccess(:final item) => ItemDetailPage(item: item),
            _ => Center(child: Text(l10n.itemFailureErrorText)),
          };
        },
      ),
    );
  }
}
