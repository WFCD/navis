import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/utils/helper_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class DealWidget extends StatelessWidget {
  const DealWidget({Key key, this.deal}) : super(key: key);

  final DarvoDeal deal;

  @override
  Widget build(BuildContext context) {
    final fontSize = SizeConfig.widthMultiplier * 3.5;
    final style = Theme.of(context).textTheme.caption.copyWith(
        fontSize: fontSize, fontWeight: FontWeight.w300, color: Colors.white);

    final primary = Theme.of(context).primaryColor;

    return FutureBuilder<BaseItem>(
      future: RepositoryProvider.of<Repository>(context).getDealItem(deal),
      builder: (BuildContext context, AsyncSnapshot<BaseItem> snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data;
          final urlExist = item.wikiaUrl != null;

          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  DealImage(imageUrl: item.imageUrl),
                  const SizedBox(width: 16.0),
                  DealDetails(
                    itemName: item.name,
                    itemDescription: parseHtmlString(item.description),
                  ),
                ],
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
                  // TODO(Orn): should probably put a plat icon here instead
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
                  CountdownBox(expiry: deal.expiry, style: style),
                ],
              ),
              if (urlExist)
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('See Wikia'),
                      onPressed: () => launchLink(item.wikiaUrl),
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
        Container(
          height: SizeConfig.heightMultiplier * 15,
          width: SizeConfig.widthMultiplier * 40,
          child: Text(
            itemDescription,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style: textTheme.caption.copyWith(
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        itemInfo ?? Container()
      ],
    );
  }
}

class DealImage extends StatelessWidget {
  const DealImage({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  Widget _placeholder(BuildContext context, String url) {
    final width = SizeConfig.widthMultiplier * 40;

    return LimitedBox(
      maxWidth: width,
      child: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorWidget(BuildContext context, String url, Object error) {
    return const NavisErrorWidget(
      title: 'Item not found by API',
      description:
          'Sorry but it seems the item hasn\'t been added to the API yet.',
      showStacktrace: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.widthMultiplier * 40;

    return LimitedBox(
      maxWidth: width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: _placeholder,
        errorWidget: _errorWidget,
      ),
    );
  }
}
