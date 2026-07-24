import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/cubit/cubit.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class TraderItemCard extends StatelessWidget {
  const TraderItemCard({super.key, required this.item, this.isVarzia = false});

  final TraderItem item;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BlocProvider(
          create: (context) => ItemCubit(RepositoryProvider.of<ItemsRepository>(context))..fetchItem(item.uniqueName),
          child: Column(
            children: [
              _TraderItemContent(item: item, isVarzia: isVarzia),
              _TraderItemTrailing(credits: item.regularPrice, ducats: item.primePrice, isVarzia: isVarzia),
            ],
          ),
        ),
      ),
    );
  }
}

class _TraderItemContent extends StatelessWidget {
  const _TraderItemContent({required this.item, this.isVarzia = false});

  final TraderItem item;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ItemCubit, ItemState, WarframeItem?>(
      selector: (state) => switch (state) {
        ItemStoreFetchSuccess(:final item) => item,
        _ => null,
      },
      builder: (context, item) {
        final imageUrl = item?.imageName.warframeItemsCdn().optimize(
          width: 256,
          pixelRatio: MediaQuery.devicePixelRatioOf(context),
        );

        return ListTile(
          leading: imageUrl != null ? CachedNetworkImage(imageUrl: imageUrl, width: 60, memCacheWidth: 256) : null,
          title: Text(item?.name ?? this.item.name),
          subtitle: item != null ? Text(item.description ?? '', maxLines: 2, overflow: .ellipsis) : null,
        );
      },
    );
  }
}

class _TraderItemTrailing extends StatelessWidget {
  const _TraderItemTrailing({required this.ducats, required this.credits, this.isVarzia = false});

  final int ducats;
  final int credits;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TrailingColumn(header: isVarzia ? 'Regal Aya' : 'Ducats', value: ducats),
          const SizedBox(width: 25),
          _TrailingColumn(header: isVarzia ? 'Aya' : 'Credits', value: credits),
        ],
      ),
    );
  }
}

class _TrailingColumn extends StatelessWidget {
  const _TrailingColumn({required this.header, required this.value});

  final String header;
  final int value;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final headerStyle = textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onSurfaceVariant);

    final valueStyle = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(header, style: headerStyle),
        Gaps.gap6,
        Text(NumberFormat().format(value), style: valueStyle),
      ],
    );
  }
}
