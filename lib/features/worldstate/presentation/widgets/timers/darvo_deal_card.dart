import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/custom_card.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:supercharged/supercharged.dart';

class DarvoDealCard extends StatefulWidget {
  const DarvoDealCard({Key key, this.deals}) : super(key: key);

  final List<DarvoDeal> deals;

  @override
  _DarvoDealCardState createState() => _DarvoDealCardState();
}

class _DarvoDealCardState extends State<DarvoDealCard> {
  List<BaseItem> items = [];

  Future<void> getInformation() async {
    final info = await context.bloc<SolsystemBloc>().getDealInformation();

    items.addAll(info);
  }

  @override
  void initState() {
    super.initState();

    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    final deal = widget.deals.first;

    return CustomCard(
      child: DealWidget(
        deal: deal,
        item: items.firstOrNull(),
      ),
    );
  }
}

class DealWidget extends StatelessWidget {
  const DealWidget({Key key, @required this.deal, this.item})
      : assert(deal != null),
        super(key: key);

  final DarvoDeal deal;
  final BaseItem item;

  @override
  Widget build(BuildContext context) {
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontWeight: FontWeight.w500);

    final primary = Theme.of(context).primaryColor;

    final urlExist = item?.wikiaUrl != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DealDetails(
            itemName: item?.name ?? '',
            itemDescription: parseHtmlString(item?.description ?? ''),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StaticBox.text(
                text: '${deal.discount}% Discount',
                color: primary,
                style: saleInfo,
              ),
              // TODO: should probably put a plat icon here instead
              StaticBox.text(
                text: '${deal.salePrice}\p',
                color: primary,
                style: saleInfo,
              ),
              StaticBox.text(
                text: '${deal.total - deal.sold} / ${deal.total} remaining',
                color: primary,
                style: saleInfo,
              ),
              CountdownTimer(expiry: deal.expiry, style: saleInfo),
            ],
          ),
          if (urlExist)
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () => launchLink(context, item.wikiaUrl),
                  child: const Text('See Wikia'),
                ),
              ],
            )
        ],
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          itemName,
          style: textTheme.subhead.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Text(
          itemDescription,
          maxLines: 7,
          overflow: TextOverflow.ellipsis,
          style: textTheme.subtitle.copyWith(color: textTheme.caption.color),
        ),
      ],
    );
  }
}
