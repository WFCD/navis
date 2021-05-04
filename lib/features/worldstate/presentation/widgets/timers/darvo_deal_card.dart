import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../bloc/darvodeal_bloc.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({Key? key, required this.deals}) : super(key: key);

  final List<DarvoDeal> deals;

  @override
  Widget build(BuildContext context) {
    final deal = deals.first;

    return CustomCard(
      child: DealWidget(deal: deal),
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
    BlocProvider.of<DarvodealBloc>(context).add(LoadDarvodeal(widget.deal));
  }

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontWeight: FontWeight.w500);

    return BlocBuilder<DarvodealBloc, DarvodealState>(
      builder: (context, state) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (state is DarvoDealLoaded)
                      DealDetails(
                        imageUrl: state.item.imageUrl,
                        itemName: widget.deal.item,
                        itemDescription:
                            state.item.description?.isNotEmpty ?? false
                                ? state.item.description?.parseHtmlString()
                                : null,
                      ),
                    const SizedBox(height: 16.0),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          if (state is DarvodealLoading)
                            StaticBox.text(text: widget.deal.item),
                          // ignore: lines_longer_than_80_chars
                          // TODO(Ornstein): should probably put a plat icon here instead
                          StaticBox.text(
                            text: '${widget.deal.salePrice}\p',
                            style: saleInfo,
                          ),
                          StaticBox.text(
                            text:
                                '${widget.deal.total - widget.deal.sold} / ${widget.deal.total}',
                            style: saleInfo,
                          ),
                          StaticBox.text(
                            text: '${widget.deal.discount}% OFF',
                            style: saleInfo,
                          ),
                          CountdownTimer(
                            expiry: widget.deal.expiry!,
                            style: saleInfo,
                          ),
                        ]),
                    if (state is DarvoDealLoaded)
                      ButtonBar(children: <Widget>[
                        if (state.item.wikiaUrl != null)
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).textTheme.button?.color),
                            ),
                            onPressed: () =>
                                state.item.wikiaUrl?.launchLink(context),
                            child: Text(context.l10n.seeWikia),
                          ),
                      ])
                  ],
                ),
              )
            ]);
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
          const SizedBox(height: 8.0),
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
    final widthRatio = mediaQuery.size.width / 100;

    final error = Icon(
      Icons.error_outline,
      size: 50,
      color: Theme.of(context).errorColor,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation sizing) {
            return CachedNetworkImage(
              imageUrl: imageUrl,
              width: widthRatio * 55,
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
