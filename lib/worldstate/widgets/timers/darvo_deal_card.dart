import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    if (previous is! SolState || current is! SolState) return true;

    return previous.worldstate.dailyDeals.equals(current.worldstate.dailyDeals);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final dailyDeals = (state as SolState).worldstate.dailyDeals;

        return AppCard(
          title: context.l10n.darvoNotificationTitle,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: _DealWidget(deal: dailyDeals.first),
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: <Widget>[
                if (state is DarvoDealLoaded)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _DealItemInformation(
                      name: deal.item,
                      description:
                          state.item.description?.parseHtmlString() ?? '',
                      imageUrl: state.item.imageUrl,
                    ),
                  ),
                _SaleInformation(
                  name: deal.item,
                  salePrice: deal.salePrice,
                  discount: deal.discount,
                  sold: deal.sold,
                  total: deal.total,
                  expiry: deal.expiry!,
                  enableNameChip: state is! DarvoDealLoaded,
                ),
                if (state is DarvoDealLoaded)
                  ButtonBar(
                    children: <Widget>[
                      if (state.item.wikiaUrl != null)
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).textTheme.labelLarge?.color,
                            ),
                          ),
                          onPressed: () =>
                              state.item.wikiaUrl?.launchLink(context),
                          child: Text(context.l10n.seeWikia),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _DealItemInformation extends StatelessWidget {
  const _DealItemInformation({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String name;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const aspectRatio = 4 / 3;
    final thumbnailWidth = context.mediaQuery.size.width * 0.45;

    return Column(
      children: [
        SizedBox(
          width: thumbnailWidth,
          height: thumbnailWidth / aspectRatio,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        ListTile(
          title: Text(name),
          subtitle: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SaleInformation extends StatelessWidget {
  const _SaleInformation({
    required this.name,
    required this.salePrice,
    required this.discount,
    required this.sold,
    required this.total,
    required this.expiry,
    this.enableNameChip = false,
  });

  final String name;
  final int salePrice;
  final int discount;
  final int sold;
  final int total;
  final DateTime expiry;
  final bool enableNameChip;

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(fontWeight: FontWeight.w500);

    final theme = context.theme;
    final color = theme.isLight
        ? theme.colorScheme.primary
        : theme.colorScheme.primaryContainer;

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 5,
        children: <Widget>[
          if (enableNameChip) ColoredContainer.text(text: name, color: color),
          ColoredContainer.text(
            text: '${salePrice}p',
            style: saleInfo,
            color: color,
          ),
          ColoredContainer.text(
            text: '${total - sold} / $total',
            style: saleInfo,
            color: color,
          ),
          ColoredContainer.text(
            text: '$discount% OFF',
            style: saleInfo,
            color: color,
          ),
          CountdownTimer(
            tooltip: context.l10n.countdownTooltip(expiry),
            expiry: expiry,
            style: saleInfo,
          ),
        ],
      ),
    );
  }
}
