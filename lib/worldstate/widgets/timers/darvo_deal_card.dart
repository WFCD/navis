import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final previousDailyDeals = switch (previous) {
      WorldstateSuccess() => previous.worldstate.dailyDeals,
      _ => <DailyDeal>[],
    };

    final nextDailyDeals = switch (next) {
      WorldstateSuccess() => next.worldstate.dailyDeals,
      _ => <DailyDeal>[],
    };

    return !previousDailyDeals.equals(nextDailyDeals);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final deal = switch (state) {
          WorldstateSuccess() => state.worldstate.dailyDeals.first,
          _ => null,
        };

        final int stock;
        if (deal != null) {
          stock = deal.total - deal.sold;
        } else {
          stock = 0;
        }

        final inStock = stock != 0;
        final expiry = deal?.expiry ?? DateTime.now();

        return ClipRRect(
          child: Banner(
            message: context.l10n.discountTitle(deal?.discount ?? 0),
            location: BannerLocation.topStart,
            child: AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${context.l10n.saleEndsTitle}:'),
                      SizedBoxSpacer.spacerWidth16,
                      CountdownTimer(
                        tooltip: context.materialLocalizations
                            .formatFullDate(expiry),
                        expiry: expiry,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  ColoredContainer.text(
                    text: inStock
                        ? context.l10n.inStockInformation(stock)
                        : context.l10n.outOfStockTitle,
                    color: inStock ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  if (deal != null) _DealWidget(deal: deal),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DealWidget extends StatefulWidget {
  const _DealWidget({required this.deal});

  final DailyDeal deal;

  @override
  State<_DealWidget> createState() => _DealWidgetState();
}

class _DealWidgetState extends State<_DealWidget> {
  bool _buildWhen(DarvodealState previous, DarvodealState current) {
    if (previous is! DarvoDealLoaded || current is! DarvoDealLoaded) {
      // Return true so the UI knows it doesn't have any info.
      return true;
    }

    return previous.item.uniqueName == current.item.uniqueName;
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<DarvodealCubit>(context)
        .fetchDeal(widget.deal.uniqueName, widget.deal.item);
  }

  @override
  void didUpdateWidget(covariant _DealWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.deal.uniqueName != widget.deal.uniqueName) {
      BlocProvider.of<DarvodealCubit>(context)
          .fetchDeal(widget.deal.uniqueName, widget.deal.item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deal = widget.deal;

    return BlocBuilder<DarvodealCubit, DarvodealState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final item = state is DarvoDealLoaded ? state.item : null;

        return Row(
          children: [
            if (item != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(item.imageUrl),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: ListTile(
                  title: Text(item?.name ?? deal.item),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: _DarvoPlatTrailing(
                salePrice: deal.salePrice,
                originalPrice: deal.originalPrice,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DarvoPlatTrailing extends StatelessWidget {
  const _DarvoPlatTrailing({
    required this.salePrice,
    required this.originalPrice,
  });

  final int salePrice;
  final int originalPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        children: [
          _DarvoPlatColumn(
            header: context.l10n.salePriceTitle,
            value: salePrice,
          ),
          Container(
            width: 10,
            height: 2,
            margin: const EdgeInsets.only(left: 8, top: 18, right: 8),
            color: context.theme.textTheme.bodyMedium?.color,
          ),
          _DarvoPlatColumn(
            header: context.l10n.originalPriceTitle,
            value: originalPrice,
          ),
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
    final headerStyle =
        textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500);
    final valueStyle =
        textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(header, style: headerStyle),
        SizedBoxSpacer.spacerHeight6,
        Text('$value'.padLeft(stringPadding, '0'), style: valueStyle),
      ],
    );
  }
}
