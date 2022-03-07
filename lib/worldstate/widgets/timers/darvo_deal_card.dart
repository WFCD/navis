import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) => (p as SolState)
          .worldstate
          .dailyDeals
          .equals((n as SolState).worldstate.dailyDeals),
      builder: (context, state) {
        final dailyDeals = (state as SolState).worldstate.dailyDeals;

        return AppCard(
          title: context.l10n.darvoNotificationTitle,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: DealWidget(deal: dailyDeals.first),
        );
      },
    );
  }
}

class DealWidget extends StatefulWidget {
  const DealWidget({Key? key, required this.deal}) : super(key: key);

  final DarvoDeal deal;

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DarvodealCubit>(context)
        .fetchDeal(widget.deal.id!, widget.deal.item);
  }

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontWeight: FontWeight.w500);

    return BlocBuilder<DarvodealCubit, DarvodealState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (state is DarvoDealLoaded)
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: state.item.imageUrl,
                      // width: 50,
                      errorWidget: (context, url, dynamic object) {
                        return Icon(
                          Icons.error_outline,
                          size: 50,
                          color: Theme.of(context).errorColor,
                        );
                      },
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    title: Text(widget.deal.item),
                    subtitle: Text(
                      state.item.description?.parseHtmlString() ?? '',
                    ),
                  ),
                SizedBoxSpacer.spacerHeight16,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 5,
                  children: <Widget>[
                    if (state is! DarvoDealLoaded)
                      ColoredContainer.text(text: widget.deal.item),
                    ColoredContainer.text(
                      text: '${widget.deal.salePrice}p',
                      style: saleInfo,
                    ),
                    ColoredContainer.text(
                      text:
                          '${widget.deal.total - widget.deal.sold} / ${widget.deal.total}',
                      style: saleInfo,
                    ),
                    ColoredContainer.text(
                      text: '${widget.deal.discount}% OFF',
                      style: saleInfo,
                    ),
                    CountdownTimer(
                      tooltip:
                          context.l10n.countdownTooltip(widget.deal.expiry!),
                      expiry: widget.deal.expiry!,
                      style: saleInfo,
                    ),
                  ],
                ),
                if (state is DarvoDealLoaded)
                  ButtonBar(
                    children: <Widget>[
                      if (state.item.wikiaUrl != null)
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).textTheme.button?.color,
                            ),
                          ),
                          onPressed: () =>
                              state.item.wikiaUrl?.launchLink(context),
                          child: Text(context.l10n.seeWikia),
                        ),
                    ],
                  )
              ],
            )
          ],
        );
      },
    );
  }
}

class DealDetails extends StatelessWidget {
  const DealDetails({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    this.itemDescription,
  }) : super(key: key);

  final String imageUrl, itemName;
  final String? itemDescription;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ItemImage(imageUrl: imageUrl),
        Text(
          itemName,
          style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w500),
        ),
        if (itemDescription != null) ...{
          SizedBoxSpacer.spacerHeight8,
          Text(
            itemDescription ?? '',
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style:
                textTheme.subtitle2?.copyWith(color: textTheme.caption?.color),
          ),
        }
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthRatio = mediaQuery.size.shortestSide / 100;

    final error = Icon(
      Icons.error_outline,
      size: 50,
      color: Theme.of(context).errorColor,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation sizing) {
            return CachedNetworkImage(
              imageUrl: imageUrl,
              width: 25,
              errorWidget: (context, url, dynamic object) => error,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
