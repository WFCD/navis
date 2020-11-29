import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../features/worldstate/presentation/bloc/solsystem_bloc.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({Key key, this.deals}) : super(key: key);

  final List<DarvoDeal> deals;

  @override
  Widget build(BuildContext context) {
    final deal = deals.first;

    return CustomCard(
      // title: NavisLocalizations.of(context).baroTitle,
      addBanner: true,
      bannerMessage: '${deal.discount}% OFF',
      child: DealWidget(deal: deal),
    );
  }
}

class DealWidget extends StatefulWidget {
  const DealWidget({Key key, @required this.deal})
      : assert(deal != null),
        super(key: key);

  final DarvoDeal deal;

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget> {
  final _mem = AsyncMemoizer<Item>();

  Future<Item> _getDeal() async {
    return _mem.runOnce(() async {
      final items =
          await BlocProvider.of<SolsystemBloc>(context).getDealInformation();

      return items.firstWhere(
        (element) =>
            element.name.toLowerCase().contains(widget.deal.item.toLowerCase()),
        orElse: () => null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle2
        .copyWith(fontWeight: FontWeight.w500);

    return FutureBuilder<Item>(
      future: _getDeal(),
      builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
        final urlExist = snapshot.data?.wikiaUrl != null;
        final deal = snapshot.data;

        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (deal != null && snapshot.hasData) ...{
                      ItemImage(imageUrl: deal.imageUrl),
                      DealDetails(
                        itemName: deal?.name ?? widget.deal.item,
                        itemDescription: deal?.description?.isNotEmpty ?? false
                            ? parseHtmlString(deal?.description)
                            : null,
                      )
                    },
                    const SizedBox(height: 16.0),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          if (deal == null && snapshot.hasData)
                            StaticBox.text(text: widget.deal.item),
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
                          CountdownTimer(
                            expiry: widget.deal.expiry,
                            style: saleInfo,
                          ),
                        ]),
                    if (deal != null && snapshot.hasData)
                      ButtonBar(children: <Widget>[
                        if (urlExist)
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).textTheme.button.color),
                            ),
                            onPressed: () => launchLink(context, deal.wikiaUrl),
                            child: Text(context.locale.seeWikia),
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

class ItemImage extends StatelessWidget {
  const ItemImage({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
            return LimitedBox(
              maxHeight: getValueForScreenType(context: context, mobile: 150),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                errorWidget: (context, url, dynamic object) => error,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DealDetails extends StatelessWidget {
  const DealDetails({
    Key key,
    this.itemName,
    this.itemDescription,
  }) : super(key: key);

  final String itemName, itemDescription;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          itemName,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
        if (itemDescription != null) ...{
          const SizedBox(height: 8.0),
          Text(
            itemDescription,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style: textTheme.subtitle2.copyWith(color: textTheme.caption.color),
          ),
        }
      ],
    );
  }
}
