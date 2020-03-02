import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/data/repositories/warframestat_repository_impl.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/custom_card.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/injection_container.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class DarvoDealCard extends StatefulWidget {
  const DarvoDealCard({Key key, this.deals}) : super(key: key);

  final List<DarvoDeal> deals;

  @override
  _DarvoDealCardState createState() => _DarvoDealCardState();
}

class _DarvoDealCardState extends State<DarvoDealCard> {
  @override
  Widget build(BuildContext context) {
    final deal = widget.deals.first;

    return CustomCard(child: DealWidget(deal: deal));
  }
}

class DealWidget extends StatelessWidget {
  const DealWidget({Key key, @required this.deal})
      : assert(deal != null),
        super(key: key);

  final DarvoDeal deal;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .caption
        .copyWith(fontWeight: FontWeight.w300);

    final primary = Theme.of(context).primaryColor;

    return FutureBuilder<BaseItem>(
      future: sl<WarframestatRepositoryImpl>().getDealInfo(deal.id, deal.item),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data as BaseItem;
          final urlExist = item.wikiaUrl != null;

          return Column(
            children: <Widget>[
              DealDetails(
                itemName: item.name,
                itemDescription: parseHtmlString(item.description),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StaticBox.text(
                    text: '${deal.discount}% Discount',
                    color: primary,
                    style: style,
                  ),
                  // TODO: should probably put a plat icon here instead
                  StaticBox.text(
                    text: '${deal.salePrice}\p',
                    color: primary,
                    style: style,
                  ),
                  StaticBox.text(
                    text: '${deal.total - deal.sold} / ${deal.total} remaining',
                    color: primary,
                    style: style,
                  ),
                  CountdownTimer(expiry: deal.expiry, style: style),
                ],
              ),
              if (urlExist)
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => launchLink(item.wikiaUrl),
                      child: const Text('See Wikia'),
                    ),
                  ],
                )
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DealDetails extends StatelessWidget {
  const DealDetails({
    Key key,
    this.itemName,
    this.itemDescription,
    this.wikiaUrl,
    this.itemInfo,
  }) : super(key: key);

  final String itemName, itemDescription, wikiaUrl;
  final Widget itemInfo;

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
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            itemDescription,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style: textTheme.subtitle.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        itemInfo ?? Container()
      ],
    );
  }
}
