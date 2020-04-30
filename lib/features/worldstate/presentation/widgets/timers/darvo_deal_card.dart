import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../features/worldstate/presentation/bloc/solsystem_bloc.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({Key key, this.deals}) : super(key: key);

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
  const DealWidget({Key key, @required this.deal})
      : assert(deal != null),
        super(key: key);

  final DarvoDeal deal;

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget> {
  final _mem = AsyncMemoizer<BaseItem>();

  Future<BaseItem> _getDeal() async {
    return _mem.runOnce(() async {
      final items = await context.bloc<SolsystemBloc>().getDealInformation();

      return items.firstWhere((element) =>
          element.name.toLowerCase().contains(widget.deal.item.toLowerCase()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle2
        .copyWith(fontWeight: FontWeight.w500);

    final primary = Theme.of(context).primaryColor;

    return FutureBuilder<BaseItem>(
        future: _getDeal(),
        builder: (BuildContext context, AsyncSnapshot<BaseItem> snapshot) {
          final urlExist = snapshot.data?.wikiaUrl != null;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DealDetails(
                  itemName: snapshot.data?.name ?? widget.deal.item ?? '',
                  itemDescription:
                      parseHtmlString(snapshot.data?.description ?? ''),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StaticBox.text(
                      text: '${widget.deal.discount}% Discount',
                      color: primary,
                      style: saleInfo,
                    ),
                    // TODO: should probably put a plat icon here instead
                    StaticBox.text(
                      text: '${widget.deal.salePrice}\p',
                      color: primary,
                      style: saleInfo,
                    ),
                    StaticBox.text(
                      text:
                          '${widget.deal.total - widget.deal.sold} / ${widget.deal.total} remaining',
                      color: primary,
                      style: saleInfo,
                    ),
                    CountdownTimer(expiry: widget.deal.expiry, style: saleInfo),
                  ],
                ),
                if (urlExist)
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () =>
                            launchLink(context, snapshot.data.wikiaUrl),
                        child: const Text('See Wikia'),
                      ),
                    ],
                  )
              ],
            ),
          );
        });
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          itemName,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Text(
          itemDescription,
          maxLines: 7,
          overflow: TextOverflow.ellipsis,
          style: textTheme.subtitle2.copyWith(color: textTheme.caption.color),
        ),
      ],
    );
  }
}
