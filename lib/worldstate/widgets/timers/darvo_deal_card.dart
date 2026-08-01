import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

typedef _StoreSales = ({List<DailyDeal> dailyDeals, List<FlashSale> flashSales});

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsRepository = RepositoryProvider.of<ItemsRepository>(context);

    return ClipRRect(
      child: BlocSelector<WorldstateBloc, WorldState, _StoreSales>(
        selector: (state) => switch (state) {
          WorldstateSuccess(:final seed) => (dailyDeals: seed.dailyDeals, flashSales: seed.flashSales),
          _ => (dailyDeals: <DailyDeal>[], flashSales: <FlashSale>[]),
        },
        builder: (context, sales) {
          final deal = sales.dailyDeals.firstOrNull;

          final stock = deal != null ? deal.total - deal.sold : 0;
          final inStock = stock != 0;
          final expiry = deal?.expiry ?? DateTime.now();

          return Banner(
            message: context.l10n.discountTitle(deal?.discount ?? 0),
            location: BannerLocation.topStart,
            child: AppCard(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${context.l10n.saleEndsTitle}:'),
                      Gaps.gap16,
                      CountdownTimer(
                        tooltip: context.materialLocalizations.formatFullDate(expiry),
                        expiry: expiry,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  ColoredContainer.text(
                    text: inStock ? context.l10n.inStockInformation(stock) : context.l10n.outOfStockTitle,
                    color: inStock ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    margin: const EdgeInsets.only(top: 10),
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  if (deal != null)
                    BlocProvider(
                      create: (_) => ItemCubit(itemsRepository)..fetchByName(deal.item),
                      child: _DealWidget(deal: deal),
                    ),
                  if (sales.flashSales.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => FlashSalesPageRoute().push<void>(context),
                        child: const Text('See all Sales'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DealWidget extends StatelessWidget {
  const _DealWidget({required this.deal});

  final DailyDeal deal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final item = switch (state) {
          ItemStoreFetchSuccess() => state.item,
          _ => null,
        };

        final row = Row(
          children: [
            if (item != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    item.imageName.warframeItemsCdn().optimize(
                      pixelRatio: MediaQuery.devicePixelRatioOf(context),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(title: Text(item?.name ?? deal.item), contentPadding: EdgeInsets.zero),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: _DarvoPlatTrailing(salePrice: deal.salePrice, originalPrice: deal.price),
            ),
          ],
        );

        if (item == null) return row;

        return OpenItemContainer(item: item, closedBuilder: (_, _) => row);
      },
    );
  }
}

class _DarvoPlatTrailing extends StatelessWidget {
  const _DarvoPlatTrailing({required this.salePrice, required this.originalPrice});

  final int salePrice;
  final int originalPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        children: [
          _DarvoPlatColumn(header: context.l10n.salePriceTitle, value: salePrice),
          Container(
            width: 10,
            height: 2,
            margin: const EdgeInsets.only(left: 8, top: 18, right: 8),
            color: context.theme.textTheme.bodyMedium?.color,
          ),
          _DarvoPlatColumn(header: context.l10n.originalPriceTitle, value: originalPrice),
        ],
      ),
    );
  }
}

class _DarvoPlatColumn extends StatelessWidget {
  const _DarvoPlatColumn({required this.header, required this.value});

  final String header;
  final int value;

  @override
  Widget build(BuildContext context) {
    const stringPadding = 2;
    final textTheme = context.textTheme;
    final headerStyle = textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500);
    final valueStyle = textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(header, style: headerStyle),
        Gaps.gap6,
        Text('$value'.padLeft(stringPadding, '0'), style: valueStyle),
      ],
    );
  }
}
